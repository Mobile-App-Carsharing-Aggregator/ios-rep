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
    let userId: Int
    let carId: Int
    let rating: Int
    let comment: String
    let created_at: String
}
