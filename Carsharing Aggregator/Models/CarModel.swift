//
//  CarModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import Foundation

struct Car: Codable {
    let id: UUID
    var isAvailable: Bool
    var company: CarsharingCompany
    let name: String
    let model: String
    let engineValue: Double
    let engineType: EngineType
    let type: CarType
    var rating: Double
    var coordinates: Coordinates
    var coefficient: Double
    let childSeat: Bool
}

struct Coordinates: Codable {
    let latitude: Float
    let longitude: Float
}

struct CarsharingCompany: Codable {
    let name: String
}

enum EngineType: Codable {
    case diesel
    case electro
    case benzine
}

enum CarType: Codable {
    case sedan
    case hatchback
    case minivan
    case coupe
    case universal
    case other
}
