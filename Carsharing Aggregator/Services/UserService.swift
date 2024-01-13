//
//  UserService.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.12.2023.
//

private struct UserRegistrationRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/users/")
    }
    var httpMethod: HttpMethod { .post }
    var dto: Encodable?
}

private struct UserLoginRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/auth/token/login/")
    }
    
    var httpMethod: HttpMethod { .post }
    var dto: Encodable?
}

private struct UserProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/users/me/")
    }
    
    var headers: [String : String]?
}

private struct ErrorResponse: Codable {
    let errors: [String: [String]]

    var allMessages: [String] {
        return errors.values.flatMap { $0 }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        errors = try container.decode([String: [String]].self)
    }
}

import Foundation

protocol UserServiceProtocol {
    func createUser(with dto: UserRegistration, completion: @escaping (Result<UserRegistrationResponse, NetworkError>) -> Void)
    func getUser(completion: @escaping (Result<UserProfile, NetworkError>) -> Void)
}

final class DefaultUserService: UserServiceProtocol {
    
    private let networkClient = DefaultNetworkClient(session: .shared, decoder: JSONDecoder(), encoder: JSONEncoder())
    
    static let shared = DefaultUserService()
    
    private init() {}
    
    func createUser(with dto: UserRegistration, completion: @escaping (Result<UserRegistrationResponse, NetworkError>) -> Void) {
        let registerRequest = UserRegistrationRequest(dto: dto)
        
        networkClient.send(request: registerRequest, type: UserRegistrationResponse.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                if case let NetworkError.httpStatusCode(_, data) = error, let data = data {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let errorMessage = errorResponse.allMessages.joined(separator: "\n")
                        print(errorMessage)
                        completion(.failure(.customError(errorMessage)))
                    } else {
                        completion(.failure(error as? NetworkError ?? .urlSessionError))
                    }
                } else {
                    completion(.failure(error as? NetworkError ?? .urlSessionError))
                }
            }
        }
    }
    
    func userLogin(with dto: UserLogin, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let loginRequest = UserLoginRequest(dto: dto)
        
        networkClient.send(request: loginRequest, type: LoginResponse.self) { result in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                if case let NetworkError.httpStatusCode(_, data) = error, let data = data {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let errorMessage = errorResponse.allMessages.joined(separator: "\n")
                        print(errorMessage)
                        completion(.failure(.customError(errorMessage)))
                    } else {
                        completion(.failure(error as? NetworkError ?? .urlSessionError))
                    }
                } else {
                    completion(.failure(error as? NetworkError ?? .urlSessionError))
                }
            }
        }
    }
    
    func getUser(completion: @escaping (Result<UserProfile, NetworkError>) -> Void) {
        guard let token = TokenStorage.shared.getToken() else {
            completion(.failure(.customError("Не найдены данные логина. Повторите процедуру логина")))
            return
        }
        
        let getProfileRequest = UserProfileRequest(headers: ["Authorization": "Token \(token)"])
        
        networkClient.send(request: getProfileRequest, type: UserProfile.self) { result in
            switch result {
            case .success(let userProfile):
                completion(.success(userProfile))
            case .failure(let error):
                if case let NetworkError.httpStatusCode(statusCode, data) = error, let data = data {
                                print("Ошибка \(statusCode): \(String(data: data, encoding: .utf8) ?? "нет данных")")
                            }
                completion(.failure(error as? NetworkError ?? .urlSessionError))
            }
        }
    }
}
