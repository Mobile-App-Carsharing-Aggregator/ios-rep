//
//  SearchCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

protocol SearchCarViewModelProtocol {
    var listOfCars: [Car] { get }
    func startObserve()
}

final class SearchCarViewModel: SearchCarViewModelProtocol {
    
    // MARK: - Observables
    @Observable
    private (set) var listOfCars: [Car] = []
    
    
    // MARK: - Properties
    weak var coordinator: SearchCarCoordinator?
    private let carsService = CarsService.shared
    
    
    //   MARK: - Methods
    func startObserve() {
        getCars()
    }
    
    func cleanUp() {
        
    }
    
    private func getCars() {
        listOfCars = carsService.getMockCars()
    }
}
