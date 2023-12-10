//
//  MapViewModel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 04.12.2023.
//

import Foundation
import YandexMapsMobile

class MapViewModel {
    weak var coordinator: MapCoordinator?
    
    func userPoint() -> YMKPoint {
        GeometryProvider.userPoint
    }
    
    func carsLocations() -> [YMKPoint] {
        GeometryProvider.carsLocations
    }
    
    func openProfile() {
        coordinator?.openProfile()
    }
    
    func openFilters() {
        coordinator?.openFilters()
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
}
