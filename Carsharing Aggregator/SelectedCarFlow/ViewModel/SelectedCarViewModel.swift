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
    private let addressService: AddressService
    
    // MARK: - LifeCycle
    init(selectedCar: Car, addressService: AddressService = AddressService()) {
        self.selectedCar = selectedCar
        self.addressService = addressService
        addressService.searchAddress(coordinates: selectedCar.coordinates, handler: handleSearchSessionResponse)
    }
    
    // MARK: - Methods
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error {
            city = "Адрес не найден"
            return
        }

        guard let response else { return }
        let geoObjects = response.collection.children.compactMap { $0.obj }
        let object = geoObjects.first?.metadataContainer.getItemOf(
            YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata
        guard let address = object?.address.formattedAddress else { return }
        
        let addressArray = address.components(separatedBy: ", ")
        city = "\(addressArray[1]), \(addressArray[0])"
        
        if addressArray.count > 2 {
            street = addressArray[2]
            let streetArray = addressArray.dropFirst(3)
            for item in streetArray {
                street.append(", \(item)")
            }
        }
    }
}
