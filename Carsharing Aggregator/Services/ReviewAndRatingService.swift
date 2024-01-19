//
//  ReviewAndRatingService.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 18.01.2024.

import Foundation

private struct ReviewAndRatingRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/cars/" + String(idCar) + "/add_review/")
    }
        var httpMethod: HttpMethod { .post }
        var dto: Encodable?
        var idCar: Int
        var headers: [String: String]?
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

protocol ReviewAndRatingServiceProtocol {
    func createReviewAndRating(with dto: ReviewAndRating, idCar: Int, completion: @escaping (Result<ReviewAndRatingResponse, NetworkError>) -> Void)
}

final class ReviewAndRatingService: ReviewAndRatingServiceProtocol {
    
    static let shared = ReviewAndRatingService()
    
    private let networkClient = DefaultNetworkClient(session: .shared, decoder: JSONDecoder(), encoder: JSONEncoder())
    
    private init() {}
    
    func createReviewAndRating(
        with dto: ReviewAndRating,
        idCar: Int,
        completion: @escaping (Result<ReviewAndRatingResponse, NetworkError>) -> Void) {
            guard let token = TokenStorage.shared.getToken() else {
                completion(.failure(.customError("Не найдены данные логина. Повторите процедуру логина")))
                return
            }
            
            let reviewRequest = ReviewAndRatingRequest(
                dto: dto, 
                idCar: idCar,
                headers: ["Authorization": "Token \(token)"])
            
            networkClient.send(
                request: reviewRequest,
                type: ReviewAndRatingResponse.self) { result in
                switch result {
                case .success(let review):
                    completion(.success(review))
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
}
