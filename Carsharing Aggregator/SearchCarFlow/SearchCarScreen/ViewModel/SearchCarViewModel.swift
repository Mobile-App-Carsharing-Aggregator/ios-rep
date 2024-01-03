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
        var carModelsDictionary: [String: CarModel] = [:]
        
        for car in cars {
            let modelKey = "\(car.brand) \(car.model)"
            if let existingCarModel = carModelsDictionary[modelKey] {
                // Если модель машины уже существует в словаре, добавляем текущий автомобиль в ее массив cars
                carModelsDictionary[modelKey]?.cars.append(car)
            } else {
                // Если модели машины еще нет в словаре, создаем новую модель и добавляем текущий автомобиль в ее массив cars
                let newCarModel = CarModel(
                    image: car.image,
                    brand: car.brand,
                    model: car.model,
                    typeCar: car.typeCar,
                    cars: [car]
                )
                carModelsDictionary[modelKey] = newCarModel
            }
        }
        return Array(carModelsDictionary.values)
    }

}

struct CarModel {
    var image: String?
    let brand: String
    let model: String
    let typeCar: CarType
    var cars: [Car]
}
