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

    private let carsharing: ListSection = {
        .carsharing([.init(title: "Яндекс.Драйв", image: ""),
                     .init(title: "СитиДрайв", image: ""),
                     .init(title: "Делимобиль", image: ""),
                     .init(title: "Rentmee", image: "")])
    }()
    
    private let typeOfCar: ListSection = {
        .typeOfCar([.init(title: "Седан", image: ""),
                     .init(title: "Хэтчбек", image: ""),
                     .init(title: "Минивен", image: ""),
                     .init(title: "Купе", image: ""),
                     .init(title: "Универсал", image: "")])
    }()
    
    private let powerReserve: ListSection = {
        .powerReserve([.init(title: "Полный бак", image: ""),
                     .init(title: "100км", image: ""),
                     .init(title: "50км", image: "")])
    }()
    
    private let rating: ListSection = {
        .rating([.init(title: "1", image: "starsmall"),
                     .init(title: "2", image: "starsmall"),
                     .init(title: "3", image: "starsmall"),
                     .init(title: "4", image: "starsmall"),
                     .init(title: "5", image: "starsmall")])
    }()
    
    var pageData: [ListSection] {
        [carsharing, typeOfCar, powerReserve, rating]
    }
}
