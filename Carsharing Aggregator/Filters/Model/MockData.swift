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
        [.init(id: 0, title: CarsharingCompany.YandexDrive.name, image: nil, name: CarsharingCompany.YandexDrive.rawValue),
         .init(id: 1, title: CarsharingCompany.CityDrive.name, image: nil, name: CarsharingCompany.CityDrive.rawValue),
         .init(id: 2, title: CarsharingCompany.Delimobil.name, image: nil, name: CarsharingCompany.Delimobil.rawValue),
         .init(id: 3, title: CarsharingCompany.BelkaCar.name, image: nil, name: CarsharingCompany.BelkaCar.rawValue)]
    }()
    
    let typeOfCar: [ListItem] = {
        [.init(id: 0, title: "Седан", image: nil, name: ""),
         .init(id: 1, title: "Хэтчбек", image: nil, name: ""),
         .init(id: 2, title: "Минивен", image: nil, name: ""),
         .init(id: 3, title: "Купе", image: nil, name: ""),
         .init(id: 4, title: "Универсал", image: nil, name: ""),
         .init(id: 5, title: "Внедорожник", image: nil, name: "")]
    }()
    
    let powerReserve: [ListItem] = {
        [.init(id: 0, title: "Полный бак", image: nil, name: ""),
         .init(id: 1, title: "100км", image: nil, name: ""),
         .init(id: 2, title: "50км", image: nil, name: "")]
    }()
    
    let different: [ListItem] = {
        [.init(id: 0, title: "Детское кресло", image: nil, name: ""),
         .init(id: 1, title: "Подогрев руля", image: nil, name: ""),
         .init(id: 2, title: "Удаленный подогрев", image: nil, name: ""),
         .init(id: 3, title: "Без оклейки", image: nil, name: ""),
         .init(id: 4, title: "Лопата", image: nil, name: ""),
         .init(id: 5, title: "Для большой компании", image: nil, name: "")]
    }()
    
    let rating: [ListItem] = {
        [.init(id: 0, title: "1", image: UIImage.starRating, name: ""),
         .init(id: 1, title: "2", image: UIImage.starRating, name: ""),
         .init(id: 2, title: "3", image: UIImage.starRating, name: ""),
         .init(id: 3, title: "4", image: UIImage.starRating, name: ""),
         .init(id: 4, title: "5", image: UIImage.starRating, name: "")]
    }()
    
    var pageData: [ListSection] {
        [.carsharing, .typeOfCar, .powerReserve, .different, .rating]
    }
}
