//
//  AddressService.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 20.12.2023.
//

import Foundation
import YandexMapsMobile

final class AddressService {
    
    // MARK: - Properties
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    private var searchSession: YMKSearchSession?
    
    // MARK: - Methods
    func searchAddress(coordinates: Coordinates, handler: @escaping YMKSearchSessionResponseHandler) {
        let coordinates = YMKPoint(
            latitude: Double(coordinates.latitude),
            longitude: Double(coordinates.longitude)
        )
        
        let searchOptions: YMKSearchOptions = {
            let options = YMKSearchOptions()
            options.searchTypes = .geo
            return options
        }()
        
        searchSession = searchManager.submit(with: coordinates, zoom: 14, searchOptions: searchOptions, responseHandler: handler)
    }
}
