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
    
    var onRefreshAction: (([IndexPath]) -> Void)?
    
    let sections: [ListSection] = [.carsharing]
    let allSections: [ListSection] = [.carsharing,
                                      .typeOfCar,
                                      .powerReserve,
                                      .rating]
    var indexPathsToUpdate: [IndexPath]?
    
    var selectedFilters: [ListSection: [ListItem]] = [:] {
        didSet {
            onRefreshAction?(indexPathsToUpdate ?? [])
            indexPathsToUpdate = []
        }
    }
    
    func filters(for section: ListSection) -> [ListItem] {
        return selectedFilters[section] ?? []
    }
    
    func change(_ item: ListItem, in section: ListSection) {
        let sectionIndex = sections.firstIndex(of: section) ?? 0
        let itemIndex = sections[sectionIndex].items.firstIndex(of: item) ?? 0
        indexPathsToUpdate = [IndexPath(item: itemIndex, section: sectionIndex)]
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
    
    func getFilters() -> [(ListItem, ListSection)] {
        var filters: [ListSection: [ListItem]]
        filters = selectedFilters
        filters.removeValue(forKey: .carsharing)
        
        var filterTuples = [(ListItem, ListSection)]()
        for key in filters.keys {
            filterTuples.append(contentsOf: filters[key]?.compactMap { ($0, key) } ?? [])
        }
        
        return filterTuples
    }
    
    func deleteSelectedFilter(item: (ListItem, ListSection)) {
        
        var sectionFilters = selectedFilters[item.1]
        sectionFilters?.removeAll(where: { filter in
            filter == item.0
        })
        selectedFilters[item.1] = sectionFilters
    }
    
    func userPoint() -> YMKPoint {
        GeometryProvider.startPoint
    }
    
    func carsLocations(completion: @escaping ([Car]) -> Void) {
        let filtersString = filtersString()
        CarsService.shared.getCars(with: filtersString, completion: completion)
    }
    
    func openProfile() {
        coordinator?.openProfile()
    }
    
    func openFilters(on vc: UIViewController, selectedFilters: [ListSection: [ListItem]]) {
        coordinator?.openFilters(on: vc, selectedFilters: selectedFilters, viewModel: self)
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
    
    private func filtersString() -> String {
        var string = FiltersRequest()
        
        for section in selectedFilters where section.value.isEmpty == false {
            let filters = section.value
            switch section.key {
            case .carsharing:
                let stringToAdd = filters.compactMap { $0.name }.joined(separator: ",")
                string.company.append(stringToAdd)
            case .typeOfCar:
                let stringToAdd = filters.compactMap { $0.name }.joined(separator: ",")
                string.typeOfCar.append(stringToAdd)
            case .powerReserve:
                string.powerReserve.append("\(filters.first?.name ?? "")")
            case .different:
                let stringToAdd = filters.compactMap { "various=" + ($0.name ?? "") }.joined(separator: "&")
                string.various.append(stringToAdd)
            case .rating:
                string.rating.append("\(filters.first?.title ?? "")")
            }
        }
        
        return string.requestString
    }
}

extension MapViewModel: FiltersViewControllerDelegate {
    func updateSelectedFilters(selectedFilters: [ListSection: [ListItem]]) {
        var indexPathes = [IndexPath]()
        allSections.forEach { section in
            section.items.forEach { item in
                if let oldFilter = self.selectedFilters[section]?.contains(item),
                   let newFilter = selectedFilters[section]?.contains(item), newFilter != oldFilter {
                    indexPathes.append(IndexPath(item: item.id, section: section.rawValue))
                }
            }
        }
        self.indexPathsToUpdate = indexPathes
        self.selectedFilters = selectedFilters
    }
}

extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}
