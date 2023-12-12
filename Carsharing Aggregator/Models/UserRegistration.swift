//
//  UserRegistration.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.12.2023.
//

import Foundation

struct UserRegistration: Encodable {
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case email, username
        case firstName = "first_name"
        case lastName = "last_name"
        case password
    }
}

struct UserRegistrationResponse: Codable {
    let id: Int
    let email: String
    let username: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id, email, username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
