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
    static let bigCompanyTitle = "Для большой компании"
    
    let carsharing: [ListItem] = {
        [.init(id: 0, title: CarsharingCompany.YandexDrive.name, image: nil, name: CarsharingCompany.YandexDrive.rawValue),
         .init(id: 1, title: CarsharingCompany.CityDrive.name, image: nil, name: CarsharingCompany.CityDrive.rawValue),
         .init(id: 2, title: CarsharingCompany.DeliMobil.name, image: nil, name: CarsharingCompany.DeliMobil.rawValue),
         .init(id: 3, title: CarsharingCompany.BelkaCar.name, image: nil, name: CarsharingCompany.BelkaCar.rawValue)]
    }()
    
    let typeOfCar: [ListItem] = {
        [.init(id: 0, title: CarType.sedan.name, image: nil, name: CarType.sedan.rawValue),
         .init(id: 1, title: CarType.hatchback.name, image: nil, name: CarType.hatchback.rawValue),
         .init(id: 2, title: CarType.minivan.name, image: nil, name: CarType.minivan.rawValue),
         .init(id: 3, title: CarType.coupe.name, image: nil, name: CarType.coupe.rawValue),
         .init(id: 4, title: CarType.universal.name, image: nil, name: CarType.universal.rawValue),
         .init(id: 5, title: CarType.suv.name, image: nil, name: CarType.suv.rawValue)]
    }()
    
    let powerReserve: [ListItem] = {
        [.init(id: 0, title: "Полный бак", image: nil, name: "3"),
         .init(id: 1, title: "100км", image: nil, name: "2"),
         .init(id: 2, title: "50км", image: nil, name: "1")]
    }()
    
    let different: [ListItem] = {
        [.init(id: 0, title: "Детское кресло", image: nil, name: Various.childSeat.rawValue),
         .init(id: 1, title: "Подогрев руля", image: nil, name: Various.heatedSteeringWheel.rawValue),
         .init(id: 2, title: "Удаленный подогрев", image: nil, name: Various.remoteHeating.rawValue),
         .init(id: 3, title: "Без оклейки", image: nil, name: Various.withoutPasting.rawValue),
         .init(id: 4, title: "Лопата", image: nil, name: Various.shovel.rawValue),
         .init(id: 5, title: bigCompanyTitle, image: nil, name: Various.forBigCompany.rawValue)]
    }()
    
    let rating: [ListItem] = {
        [.init(id: 0, title: "1", image: UIImage.starRating, name: ""),
         .init(id: 1, title: "2", image: UIImage.starRating, name: ""),
         .init(id: 2, title: "3", image: UIImage.starRating, name: ""),
         .init(id: 3, title: "4", image: UIImage.starRating, name: ""),
         .init(id: 4, title: "5", image: UIImage.starRating, name: "")]
    }()
    
    let smallCarsTitles: [String] = {
        ["Седан", "Хэтчбек", "Универсал", "Купе"]
    }()
    
    var pageData: [ListSection] {
        [.carsharing, .typeOfCar, .powerReserve, .different, .rating]
    }
}
