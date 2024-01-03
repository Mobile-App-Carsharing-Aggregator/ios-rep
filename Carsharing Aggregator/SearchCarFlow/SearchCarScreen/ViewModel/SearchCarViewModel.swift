//
//  SearchCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

protocol SearchCarViewModelProtocol {
    var carModels: [CarModel] { get }
    func viewWillAppear()
}

final class SearchCarViewModel: SearchCarViewModelProtocol {
    
    // MARK: - Observables
    @Observable
    private (set) var carModels: [CarModel] = []
    
    @Observable
    private (set) var isLoading: Bool = false
    
    // MARK: - Properties
    weak var coordinator: SearchCarCoordinator?
    private let carsService = CarsService.shared
    
    // MARK: - Methods
    func viewWillAppear() {
        getCars()
    }
    
    func cleanUp() {
        
    }
    
    private func getCars() {
        isLoading = true
        carsService.getCars { [weak self] cars in
            DispatchQueue.main.async {
                guard let self else { return }
                self.carModels = self.getUniqCarModel(cars: cars)
                self.isLoading = false
            }
            
        }
    }
    
    private func getUniqCarModel(cars: [Car]) -> [CarModel] {
        var models: [CarModel] = []
        
        return models
    }
}

struct CarModel {
    var image: String?
    let brand: String
    let model: String
    let typeCar: CarType
    var compaies: [CarsharingCompany]
}
