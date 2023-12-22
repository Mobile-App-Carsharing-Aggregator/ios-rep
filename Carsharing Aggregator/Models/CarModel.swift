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
    case yandexDrive = "YandexDrive"
    case cityDrive = "СитиДрайв"
    case delimobil = "Делимобиль"
    case rentmee = "Rentmee"
    
    var color: UIColor {
        switch self {
        case .yandexDrive:
            return UIColor.carsharing.lightBlue
        case .cityDrive:
            return UIColor.carsharing.purple
        case .delimobil:
            return UIColor.carsharing.lightGreen
        case .rentmee:
            return UIColor.carsharing.mediumGreen
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .yandexDrive:
            UIImage.pointLightBlue ?? UIImage()
        case .cityDrive:
            UIImage.pointPurple ?? UIImage()
        case .delimobil:
            UIImage.pointLightGreen ?? UIImage()
        case .rentmee:
            UIImage.pointMediumGreen ?? UIImage()
        }
    }
    
    var name: String {
        switch self {
        case .yandexDrive:
            "Яндекс.Драйв"
        case .cityDrive:
            "СитиДрайв"
        case .delimobil:
            "Делимобиль"
        case .rentmee:
            "Rentmee"
        }
    }
    
//    init?(rawValue: String) {
//        switch rawValue {
//        case "CityDrive":
//            self = .cityDrive
//        case "YandexDrive":
//            self = .yandexDrive
//        case "BelkaCar":
//            self = .delimobil
//        default:
//            self = .rentmee
//        }
//    }
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
