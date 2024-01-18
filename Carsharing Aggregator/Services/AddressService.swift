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
    func searchAddress(coordinates: Coordinates, completion: @escaping (String, String) -> Void) {
        let searchCoordinates = YMKPoint(
            latitude: Double(coordinates.latitude),
            longitude: Double(coordinates.longitude)
        )
        
        let searchOptions: YMKSearchOptions = {
            let options = YMKSearchOptions()
            options.searchTypes = .geo
            return options
        }()
        
        let searchHandler = { (response: YMKSearchResponse?, error: Error?) -> Void in
            if let error {
                print(error)
                completion("Адрес не найден", "")
            }

            guard let response else { return }
            let geoObjects = response.collection.children.compactMap { $0.obj }
            let object = geoObjects.first?.metadataContainer.getItemOf(
                YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata
            guard let address = object?.address.formattedAddress else { return }
            
            let addressArray = address.components(separatedBy: ", ")
            var city = ""
            
            if addressArray.count == 1 { city = addressArray[0] }
            if addressArray.count > 1 { city = "\(addressArray[1]), \(addressArray[0])" }
            
            var street = ""
            
            if addressArray.count > 2 {
                street = addressArray[2]
                let streetArray = addressArray.dropFirst(3)
                for item in streetArray {
                    street.append(", \(item)")
                }
            }
            
            completion(city, street)
        }
        
        searchSession = searchManager.submit(
            with: searchCoordinates,
            zoom: 14,
            searchOptions: searchOptions,
            responseHandler: searchHandler
        )
    }
}
