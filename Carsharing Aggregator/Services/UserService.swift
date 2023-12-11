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

import Foundation

protocol UserServiceProtocol {
    func createUser(with dto: UserRegistration, completion: @escaping (Result<UserRegistrationResponse, NetworkError>) -> Void)
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
                completion(.failure(error as? NetworkError ?? .urlSessionError))
            }
        }
        
    }
}
