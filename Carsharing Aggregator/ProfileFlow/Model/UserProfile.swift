//
//  UserProfile.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 12.01.2024.
//

import Foundation

struct UserProfile: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let coordinates: Coordinates?
}
