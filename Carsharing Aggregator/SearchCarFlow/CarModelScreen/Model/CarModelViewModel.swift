//
//  CarModelViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 22.01.2024.
//

import Foundation

final class CarModelViewModel {
    
    // MARK: - Observables
    @Observable
    private (set) var carModel: CarModel?
    
    // MARK: - Properties
    weak var coordinator: CarModelCoordinator?
    
    // MARK: - Methods
    func viewWillAppear() {
       getCarModel()
    }
    
    func didTapCloseButton() {
        coordinator?.parent?.coordinatorDidFinish()
    }
    
    private func getCarModel() {
        carModel = coordinator?.selectedCarModel
    }
    
}
