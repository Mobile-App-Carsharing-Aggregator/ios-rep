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
    
    var onRefreshAction: ((IndexPath) -> Void)?
    let sections: [ListSection] = [.carsharing]
    var indexPathToUpdate: IndexPath?
    
    private var selectedCarsharing: [ListSection: [ListItem]] = [:] {
        didSet {
            if let indexPathToUpdate {
                onRefreshAction?(indexPathToUpdate)
            }
            indexPathToUpdate = nil
        }
    }
    
    func filters(for section: ListSection) -> [ListItem] {
        selectedCarsharing[section] ?? []
    }
    
    func change(_ item: ListItem, in section: ListSection) {
        let sectionIndex = sections.firstIndex(of: section) ?? 0
        let itemIndex = sections[sectionIndex].items.firstIndex(of: item) ?? 0
        indexPathToUpdate = IndexPath(item: itemIndex, section: sectionIndex)
        if let index = selectedCarsharing[section]?.firstIndex(of: item) {
            selectedCarsharing[section]?.remove(at: index)
        } else {
            if let filters = selectedCarsharing[section],
               !filters.isEmpty {
                selectedCarsharing[section]?.append(item)
            } else {
                selectedCarsharing[section] = [item]
            }
        }
    }
    
    func userPoint() -> YMKPoint {
        GeometryProvider.startPoint
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
    
    func openSearchCar(on vc: UIViewController) {
        coordinator?.openSearchCar(on: vc)
    }
    
    func openCar(on vc: UIViewController, with car: Car) {
        coordinator?.openCar(on: vc, with: car)
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
    
    func getFilters() -> [String] {
        ["Седан", "Хэтчбек", "50 км", "4", "sflsjfslfldjshfb"]
    }
}
