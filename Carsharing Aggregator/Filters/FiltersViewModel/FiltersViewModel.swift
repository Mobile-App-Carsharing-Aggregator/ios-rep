//
//  FiltersViewModel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import Foundation

class FiltersViewModel {
    weak var coordinator: FiltersCoordinator?
    
    var onRefreshAction: ((_ indexPathToUpdate: IndexPath, _ shouldUpdateCars: Bool) -> Void)?
    let sections: [ListSection] = [.carsharing,
                                   .typeOfCar,
                                   .powerReserve,
                                   .different,
                                   .rating]
    var indexPathToUpdate: IndexPath?
    var shouldUpdateCars: Bool = false
  
    var selectedFilters: [ListSection: [ListItem]] = [:] {
        didSet {
            if let indexPathToUpdate {
                onRefreshAction?(indexPathToUpdate, shouldUpdateCars)
            }
            indexPathToUpdate = nil
            shouldUpdateCars = false
        }
    }
    
    var isSelectedBigCompany: Bool {
        selectedFilters[ListSection.different]?.contains(where: { item in
            item.title == MockData.bigCompanyTitle
        }) ?? false
    }
    
    var titleNumberOfCarsButton: String = "ПОКАЗАТЬ"
        
    func filters(for section: ListSection) -> [ListItem] {
        selectedFilters[section] ?? []
    }
    
    func change(_ item: ListItem, in section: ListSection) {
        let sectionIndex = sections.firstIndex(of: section) ?? 0
        let itemIndex = sections[sectionIndex].items.firstIndex(of: item) ?? 0
        indexPathToUpdate = IndexPath(item: itemIndex, section: sectionIndex)
        if item.title == MockData.bigCompanyTitle {
            shouldUpdateCars = true
        } else {
            shouldUpdateCars = false
        }
        
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
        
        if item.title == MockData.bigCompanyTitle {
            removeSmallCars()
        }
    }
    
    func removeSmallCars() {
        var cars = selectedFilters[.typeOfCar]
        selectedFilters[.typeOfCar] = cars?.filter({ item in
            !MockData.shared.smallCarsTitles.contains(item.title)
        })
    }
}
