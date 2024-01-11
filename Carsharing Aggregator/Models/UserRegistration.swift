//
//  UserRegistration.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.12.2023.
//

import Foundation

struct UserRegistration: Encodable {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let confirmPassword: String

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case confirmPassword = "re_password"
    }
}

struct UserRegistrationResponse: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
}

struct UserLogin: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let authToken: String
}
