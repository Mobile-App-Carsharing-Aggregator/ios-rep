//
//  ListingFilters.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import Foundation

enum ListSection: Hashable {
    case carsharing
    case typeOfCar
    case powerReserve
    case rating
    
    var items: [ListItem] {
        switch self {
        case .carsharing:
            return MockData.shared.carsharing
        case .typeOfCar:
            return MockData.shared.typeOfCar
        case .powerReserve:
            return MockData.shared.powerReserve
        case .rating:
            return MockData.shared.rating
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .carsharing:
            return "Каршеринг"
        case .typeOfCar:
            return "Тип автомобиля"
        case .powerReserve:
            return "Запас хода"
        case .rating:
            return "Рейтинг"
        }
    }
}
