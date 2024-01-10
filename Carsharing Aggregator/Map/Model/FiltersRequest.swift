//
//  FiltersRequest.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 10.01.2024.
//

import Foundation

struct FiltersRequest {
    var company = "company="
    var typeOfCar = "type_car="
    var powerReserve = "power_reserve="
    var rating = "rating="
    var various = ""
    
    var requestString: String {
        return "?" + company + "&\(typeOfCar)" + "&\(powerReserve)" + "&\(rating)" + "&\(various)"
    }
}
