//
//  FiltersViewModel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import Foundation

class FiltersViewModel {
    weak var coordinator: FiltersCoordinator?
    
    var onRefreshAction: ((IndexPath) -> Void)?
    let sections: [ListSection] = [.carsharing,
                                   .typeOfCar,
                                   .powerReserve,
                                   .different,
                                   .rating]
    var indexPathToUpdate: IndexPath?
    
    var selectedFilters: [ListSection: [ListItem]] = [:] {
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
    
    func filtersString() -> String {
        var string = ""
        
        for section in selectedFilters where section.value.isEmpty == false {
            let filters = section.value
            switch section.key {
            case .carsharing:
                if string != "" { string.append("&") }
                string.append("company=")
                let stringToAdd = filters.compactMap { $0.name }.joined(separator: ",")
                string.append(stringToAdd)
            case .typeOfCar:
                if string != "" { string.append("&") }
                string.append("type_car=")
                let stringToAdd = filters.compactMap { $0.name }.joined(separator: ",")
                string.append(stringToAdd)
            case .powerReserve:
                if string != "" { string.append("&") }
                string.append("power_reserve=")
                string.append("\(filters.first?.name ?? "")")
            case .different:
                for filter in filters {
                    switch filter.title {
                    case "Детское кресло":
                        if string != "" { string.append("&") }
                        string.append(filter.name ?? "")
                    default:
                        continue
                    }
                }
            case .rating:
                if string != "" { string.append("&") }
                string.append("rating=")
                string.append("\(filters.first?.title ?? "")")
            }
        }
        
        if string != "" { string.insert("?", at: string.startIndex ) }
        return string
    }
}
