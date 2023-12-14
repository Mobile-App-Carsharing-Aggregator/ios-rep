//
//  SelectedCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import Foundation

final class SelectedCarViewModel {
    
    // MARK: - Properties
    weak var coordinator: SelectedCarCoordinator?
    private (set) var selectedCar: Car
    
    // MARK: - LifeCycle
    init(selectedCar: Car) {
        self.selectedCar = selectedCar
    }
}
