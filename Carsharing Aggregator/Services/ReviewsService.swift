//
//  ReviewsService.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 21.01.2024.
//

import Foundation

private struct GetReviewsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/reviews/?user=" + userId)
    }
    var httpMethod: HttpMethod { .get }
    
    var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}

final class ReviewsService {
    
    private let networkClient = DefaultNetworkClient(session: .shared, decoder: JSONDecoder(), encoder: JSONEncoder())
    
    func getReviews(for userId: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        let getReviewsRequest = GetReviewsRequest(userId: userId)
        
        networkClient.send(request: getReviewsRequest, type: [Review].self) { result in
            DispatchQueue.main.async {
                print(result)
                completion(result)
            }
        }
    }
}
