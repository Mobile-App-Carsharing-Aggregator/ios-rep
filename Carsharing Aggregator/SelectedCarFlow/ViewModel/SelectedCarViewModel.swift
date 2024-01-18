//
//  SelectedCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import Foundation

final class SelectedCarViewModel {
    
    // MARK: - Observables
    @Observable
    private(set) var city = ""
    
    @Observable
    private(set) var street = ""
    
    @Observable
    private(set) var time = ""
    
    // MARK: - Properties
    weak var coordinator: SelectedCarCoordinator?
    private (set) var selectedCar: Car
    private let addressService: AddressService
    private let routeService: RouteService
    
    // MARK: - LifeCycle
    init(
        selectedCar: Car,
        addressService: AddressService = AddressService(),
        routeService: RouteService = RouteService()
    ) {
        self.selectedCar = selectedCar
        self.addressService = addressService
        self.routeService = routeService
        calculateTime()
        searchAddress()
    }
    
    // MARK: - Methods
    private func calculateTime() {
        routeService.calculateTime(carCoordinates: selectedCar.coordinates) { [weak self] routeTime in
            self?.time = routeTime
        }
    }
    
    private func searchAddress() {
        addressService.searchAddress(coordinates: selectedCar.coordinates) { [weak self] cityAddress, streetAddress in
            self?.city = cityAddress
            self?.street = streetAddress
        }
    }
    
    func saveInfoAboutCar() {
        if let token = TokenStorage.shared.getToken() {
            let defaults = UserDefaults.standard
            let car = selectedCar
            let carDictionary = ["id": String(car.id),
                                 "model": car.brand + " " + car.model] as [String: String]
            defaults.setValue(carDictionary, forKey: "car")
        }
    }
}
