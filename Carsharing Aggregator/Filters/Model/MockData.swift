//
//  MockData.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 09.12.2023.
//

import Foundation
import UIKit

struct MockData {
    static let shared = MockData()
    
    let carsharing: [ListItem] = {
        [.init(title: "YandexDrive", image: ""),
         .init(title: "CityDrive", image: ""),
         .init(title: "Delimobil", image: ""),
         .init(title: "BelkaCar", image: "")]
    }()
    
    let typeOfCar: [ListItem] = {
        [.init(title: "Седан", image: ""),
         .init(title: "Хэтчбек", image: ""),
         .init(title: "Минивен", image: ""),
         .init(title: "Купе", image: ""),
         .init(title: "Универсал", image: "")]
    }()
    
    let powerReserve: [ListItem] = {
        [.init(title: "Полный бак", image: ""),
         .init(title: "100км", image: ""),
         .init(title: "50км", image: "")]
    }()
    
    let rating: [ListItem] = {
        [.init(title: "1", image: "starsmall"),
         .init(title: "2", image: "starsmall"),
         .init(title: "3", image: "starsmall"),
         .init(title: "4", image: "starsmall"),
         .init(title: "5", image: "starsmall")]
    }()
    
    var pageData: [ListSection] {
        [.carsharing, .typeOfCar, .powerReserve, .rating]
    }
}
