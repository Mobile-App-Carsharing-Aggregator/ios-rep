//
//  CarModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import UIKit

struct GetCarsResponse: Codable {
    let count: Int
    let results: [Car]
}

struct Car: Codable {
    let image: String?
    let id: Int
    var isAvailable: Bool
    var company: CarsharingCompany
    let brand: String
    let model: String
    let typeEngine: EngineType
    let various: [Various]
    let typeCar: CarType
    let powerReserve: String
    var rating: String
    var coordinates: Coordinates
    let stateNumber: String
}

struct Coordinates: Codable {
    let latitude: Float
    let longitude: Float
}

enum Various: String, Codable {
    case childSeat = "child_seat"
    case heatedSteeringWheel = "heated_steering_wheel"
    case remoteHeating = "remote_heating"
    case withoutPasting = "without_pasting"
    case shovel = "shovel"
    case forBigCompany = "for_big_company"
}

enum CarsharingCompany: String, Codable, CaseIterable {
    case YandexDrive
    case CityDrive
    case DeliMobil
    case BelkaCar
    
    var color: UIColor {
        switch self {
        case .YandexDrive:
            return UIColor.carsharing.lightBlue
        case .CityDrive:
            return UIColor.carsharing.purple
        case .DeliMobil:
            return UIColor.carsharing.darkGreen
        case .BelkaCar:
            return UIColor.carsharing.navi
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .YandexDrive:
            UIImage.pointYandex ?? UIImage()
        case .CityDrive:
            UIImage.pointCitydrive ?? UIImage()
        case .DeliMobil:
            UIImage.pointDelimobil ?? UIImage()
        case .BelkaCar:
            UIImage.pointBelka ?? UIImage()
        }
    }
    
    var bigIcon: UIImage {
        switch self {
        case .YandexDrive:
            UIImage.drive ?? UIImage()
        case .CityDrive:
            UIImage.city ?? UIImage()
        case .DeliMobil:
            UIImage.deli ?? UIImage()
        case .BelkaCar:
            UIImage.belka ?? UIImage()
        }
    }
    
    var name: String {
        switch self {
        case .YandexDrive:
            "Яндекс.Драйв"
        case .CityDrive:
            "СитиМобиль"
        case .DeliMobil:
            "Делимобиль"
        case .BelkaCar:
            "BelkaCar"
        }
    }
    
    var price: Int {
        switch self {
        case .YandexDrive:
            8
        case .CityDrive:
            7
        case .DeliMobil:
            7
        case .BelkaCar:
            8
        }
    }
    
    var appStoreID: String {
        switch self {
        case .YandexDrive:
            "1318875022"
        case .CityDrive:
            "579220388"
        case .DeliMobil:
            "1038254296"
        case .BelkaCar:
            "1113709902"
        }
    }
}

enum EngineType: String, Codable {
    case diesel
    case electro
    case benzine
}

enum CarType: String, Codable {
    case sedan
    case hatchback
    case minivan
    case coupe
    case universal
    case suv
    
    var name: String {
        switch self {
        case .sedan:
            "Седан"
        case .hatchback:
            "Хэтчбек"
        case .minivan:
            "Минивен"
        case .coupe:
            "Купе"
        case .universal:
            "Универсал"
        case .suv:
            "Внедорожник"
        }
    }
}

struct Cars: Codable {
//    let id: Int
//    let coordinates: Coordinates
//    let isAvailable: Bool
//    let company, brand, model, typeCar: String
//    let stateNumber, typeEngine: String
//    let childSeat: Bool
//    let powerReserve: Int
//    let rating: String
    let image: String?
    let id: Int
    var isAvailable: Bool
    var company: String
    let brand: String
    let model: String
    let typeEngine: String
    let typeCar: String
    var rating: String
    var coordinates: Coordinates
    let childSeat: Bool
}

struct CarModel {
    var image: String?
    let brand: String
    let model: String
    let typeCar: CarType
    var cars: [Car]
    var companies: [CarsharingCompany]
}
