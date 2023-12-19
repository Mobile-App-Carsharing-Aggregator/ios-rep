//
//  SelectedCarViewModel.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import Foundation
import YandexMapsMobile

final class SelectedCarViewModel {
    
    // MARK: - Observables
    @Observable
    private(set) var city = ""
    
    @Observable
    private(set) var street = ""
    
    // MARK: - Properties
    weak var coordinator: SelectedCarCoordinator?
    private (set) var selectedCar: Car
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    private var searchSession: YMKSearchSession?
    
    // MARK: - LifeCycle
    init(selectedCar: Car) {
        self.selectedCar = selectedCar
        searchAddress()
    }
    
    // MARK: - Methods
    func searchAddress() {
        let coordinates = YMKPoint(
            latitude: Double(selectedCar.coordinates.latitude),
            longitude: Double(selectedCar.coordinates.longitude)
        )
        
        let searchOptions: YMKSearchOptions = {
            let options = YMKSearchOptions()
            options.searchTypes = .geo
            return options
        }()
        
        searchSession = searchManager.submit(with: coordinates, zoom: 14, searchOptions: searchOptions, responseHandler: handleSearchSessionResponse)
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error {
            street = "Адрес не найден"
            return
        }

        guard let response else { return }
        let geoObjects = response.collection.children.compactMap { $0.obj }
        let object = geoObjects.first?.metadataContainer.getItemOf(YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata
        guard let address = object?.address.formattedAddress else { return }
        
        let arr = address.components(separatedBy: ", ")
        city = "\(arr[1]), \(arr[0])"
        if arr.count == 4 {
            street = "\(arr[2]), \(arr[3])"
        } else if arr.count == 3 {
            street = (arr[2])
        }
    }
}
