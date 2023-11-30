//
//  Models.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import Foundation

struct User: Codable {
    let userID: UUID
    var name: String
    var surname: String
    var email: String
    var phoneNumber: String
    var bonuses: Int
    var paymentCards: [PaymentCard]
    var orders: [Order]
    
}

struct PaymentCard: Codable {
    let cardNumber: Int
    let expiryDate: Int
    let cvv: Int
}

struct Order: Codable {
    let state: TypeOfOrder
    let date: String
    let car: Car
    let startPoint: String
    let endPoint: String
}


enum TypeOfOrder: Codable {
    case Active
    case Finished
}
