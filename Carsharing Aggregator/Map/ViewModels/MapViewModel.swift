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
    
    func carsLocations(completion: @escaping ([Car]) -> Void) {
        CarsService.shared.getCars(completion: completion)
    }
    
    func openProfile() {
        coordinator?.openProfile()
    }
    
    func openFilters(on vc: UIViewController) {
        coordinator?.openFilters(on: vc)
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
}
