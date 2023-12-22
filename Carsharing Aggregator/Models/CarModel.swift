//
//  CarModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import UIKit

struct GetCarsResponse: Codable {
    let count: Int
    let results: [Cars]
}

struct Car: Codable {
    let image: String
    let id: Int
    var isAvailable: Bool
    var company: String
    let brand: String
    let model: String
    let engineValue: Double
    let typeEngine: String
    let typeCar: String
    var rating: Double
    var coordinates: Coordinates
    var coefficient: Double
    let childSeat: Bool
}

struct Coordinates: Codable {
    let latitude: Float
    let longitude: Float
}

enum CarsharingCompany: String, Codable, CaseIterable {
    case YandexDrive = "YandexDrive"
    case CityDrive = "СитиДрайв"
    case Delimobil = "Делимобиль"
    case Rentmee = "Rentmee"
    
    var color: UIColor {
        switch self {
        case .YandexDrive:
            return UIColor.carsharing.lightBlue
        case .CityDrive:
            return UIColor.carsharing.purple
        case .Delimobil:
            return UIColor.carsharing.lightGreen
        case .Rentmee:
            return UIColor.carsharing.mediumGreen
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .YandexDrive:
            UIImage.pointLightBlue ?? UIImage()
        case .CityDrive:
            UIImage.pointPurple ?? UIImage()
        case .Delimobil:
            UIImage.pointLightGreen ?? UIImage()
        case .Rentmee:
            UIImage.pointMediumGreen ?? UIImage()
        }
    }
    
    var name: String {
        switch self {
        case .YandexDrive:
            "Яндекс.Драйв"
        case .CityDrive:
            "СитиДрайв"
        case .Delimobil:
            "Делимобиль"
        case .Rentmee:
            "Rentmee"
        }
    }
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

struct Cars: Codable {
    let id: Int
    let coordinates: Coordinates
    let isAvailable: Bool
    let company, brand, model, typeCar: String
    let stateNumber, typeEngine: String
    let childSeat: Bool
    let powerReserve: Int
    let rating: String
}
