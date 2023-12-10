//
//  ListingFilters.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import Foundation

enum ListSection {
    case carsharing([ListItem])
    case typeOfCar([ListItem])
    case powerReserve([ListItem])
    case rating([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .carsharing(let items),
                .typeOfCar(let items),
                .powerReserve(let items),
                .rating(let items):
            return items
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
