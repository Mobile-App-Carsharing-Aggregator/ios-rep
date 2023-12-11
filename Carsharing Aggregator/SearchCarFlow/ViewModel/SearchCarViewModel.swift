//
//  SearchCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

protocol SearchCarViewModelProtocol {
    var listOfCars: [Car] { get }
}

final class SearchCarViewModel: SearchCarViewModelProtocol {
    
    private let carsService = CarsService.shared
    
    private (set) var listOfCars: [Car] = []
}
