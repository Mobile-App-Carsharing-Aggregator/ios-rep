//
//  ListingFilters.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import Foundation

enum ListSection: Int, Hashable {
    case carsharing = 0
    case typeOfCar
    case powerReserve
    case different
    case rating
    
    var items: [ListItem] {
        switch self {
        case .carsharing:
            MockData.shared.carsharing
        case .typeOfCar:
            MockData.shared.typeOfCar
        case .powerReserve:
            MockData.shared.powerReserve
        case .different:
            MockData.shared.different
        case .rating:
            MockData.shared.rating
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
        case.different:
            return "Разное"
        case .rating:
            return "Рейтинг"
        }
    }
}
