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
        [.init(id: 0, title: "Яндекс.Драйв", image: nil),
         .init(id: 1, title: "СитиДрайв", image: nil),
         .init(id: 2, title: "Делимобиль", image: nil),
         .init(id: 3, title: "Rentmee", image: nil)]
    }()
    
    let typeOfCar: [ListItem] = {
        [.init(id: 0, title: "Седан", image: nil),
         .init(id: 1, title: "Хэтчбек", image: nil),
         .init(id: 2, title: "Минивен", image: nil),
         .init(id: 3, title: "Купе", image: nil),
         .init(id: 4, title: "Универсал", image: nil)]
    }()
    
    let powerReserve: [ListItem] = {
        [.init(id: 0, title: "Полный бак", image: nil),
         .init(id: 1, title: "100км", image: nil),
         .init(id: 2, title: "50км", image: nil)]
    }()
    
    let rating: [ListItem] = {
        [.init(id: 0, title: "1", image: UIImage.starRating),
         .init(id: 1, title: "2", image: UIImage.starRating),
         .init(id: 2, title: "3", image: UIImage.starRating),
         .init(id: 3, title: "4", image: UIImage.starRating),
         .init(id: 4, title: "5", image: UIImage.starRating)]
    }()
    
    var pageData: [ListSection] {
        [.carsharing, .typeOfCar, .powerReserve, .rating]
    }
}
