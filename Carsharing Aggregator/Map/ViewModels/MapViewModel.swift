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
    
    private var selectedFilters: [ListSection: [ListItem]] = [:] {
        didSet {
            if let indexPathToUpdate {
                onRefreshAction?(indexPathToUpdate)
            }
            indexPathToUpdate = nil
        }
    }
    
    func filters(for section: ListSection) -> [ListItem] {
        selectedFilters[section] ?? []
    }
    
    func change(_ item: ListItem, in section: ListSection) {
        let sectionIndex = sections.firstIndex(of: section) ?? 0
        let itemIndex = sections[sectionIndex].items.firstIndex(of: item) ?? 0
        indexPathToUpdate = IndexPath(item: itemIndex, section: sectionIndex)
        if let index = selectedFilters[section]?.firstIndex(of: item) {
            selectedFilters[section]?.remove(at: index)
        } else {
            if let filters = selectedFilters[section],
               !filters.isEmpty {
                selectedFilters[section]?.append(item)
            } else {
                selectedFilters[section] = [item]
            }
        }
    }
    
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
