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
    
    private func getCars() {
        isLoading = true
        carsService.getCars(with: "") { [weak self] cars in
            DispatchQueue.main.async {
                guard let self else { return }
                self.carModels = self.getUniqCarModel(cars: cars)
                self.isLoading = false
            }
        }
    }
    
    func didSelected(on vc: UIViewController, carModel: CarModel) {
        coordinator?.openSelectedCarModel(on: vc, carModel: carModel)
    }
    
    private func getUniqCarModel(cars: [Car]) -> [CarModel] {
        var carModelsDictionary: [String: CarModel] = [:]
        
        for car in cars {
            let modelKey = "\(car.brand) \(car.model)"
            // Если модель уже существует, добавляем текущий автомобиль в массив cars и уникальную компанию в массив companies
            if var existingCarModel = carModelsDictionary[modelKey] {
                existingCarModel.cars.append(car)
                
                if !existingCarModel.companies.contains(car.company) {
                    existingCarModel.companies.append(car.company)
                }
                carModelsDictionary[modelKey] = existingCarModel
            } else {
                // Создаем новую модель машины и добавляем ее в словарь
                let newCarModel = CarModel(
                    image: car.image ?? cars.first?.image,
                    brand: car.brand,
                    model: car.model,
                    typeCar: car.typeCar,
                    cars: [car],
                    companies: [car.company]
                )
                carModelsDictionary[modelKey] = newCarModel
            }
        }
        let carModels = Array(carModelsDictionary.values).sorted {
            if $0.brand == $1.brand {
                return $0.model < $1.model
            }
            return $0.brand < $1.brand
        }
        return carModels
    }

}
