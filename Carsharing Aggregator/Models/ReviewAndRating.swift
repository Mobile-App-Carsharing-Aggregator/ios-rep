//
//  ReviewAndRating.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 18.01.2024.
//

import Foundation

struct ReviewAndRating: Encodable {
    let rating: Int
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case rating, comment
    }
}

struct ReviewAndRatingResponse: Codable {
    let message: String
    let review: Review
}

struct Review: Codable {
    let user: Int
    let car: Int
    let rating: Float
    let comment: String
    let createdAt: String
}

struct GetReviewsResponse: Codable {
    let count: Int
    let results: [Review]
}
