//
//  CarsService.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 10.12.2023.
//

private struct GetCarsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/cars/")
    }
    var httpMethod: HttpMethod { .get }
}

import Foundation

protocol CarsServiceProtocol {
    func getCars(completion: @escaping ([Car]) -> Void)
}

final class CarsService: CarsServiceProtocol {
    
    static let shared = CarsService()
    
    private let networkClient = DefaultNetworkClient(session: .shared, decoder: JSONDecoder(), encoder: JSONEncoder())
    
    private init() {}
    
    func getCars(completion: @escaping ([Car]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let cars = self?.getMockCars() else { return }
            completion(cars)
        }
        getCarsFromNetwork { result in
            switch result {
            case .success(let carsResponse):
                print("carsResponse: \(carsResponse.results)")
            case .failure(let error):
                print("error \(error)")
            
            }
        }
    }
    
    func getCarsFromNetwork(completion: @escaping (Result<GetCarsResponse, NetworkError>) -> Void) {
        let getCarsRequest = GetCarsRequest()
        
        networkClient.send(request: getCarsRequest, type: GetCarsResponse.self) { result in
            switch result {
            case .success(let carsResponse):
                completion(.success(carsResponse))
            case .failure(let error):
                completion(.failure(error as? NetworkError ?? .urlSessionError))
            }
        }
    }
}

// MARK: - MOCK

extension CarsService {
    
    func getMockCars() -> [Car] {
        var cars: [Car] = []
        let carsharingCompany: [CarsharingCompany] = CarsharingCompany.allCases
        let engineTypes: [EngineType] = [.diesel, .electro, .benzine]
        let carTypes: [CarType] = [.sedan, .hatchback, .minivan, .coupe, .universal, .other]
        
        for (index, location) in carsLocations.enumerated() {
            let car = Car(
                image: "", id: Array(0...30).randomElement()!,
                isAvailable: index % 2 == 0,
                company: carsharingCompany.randomElement()!,
                brand: "Машина \(index + 1)",
                model: "Модель \(index + 1)",
                engineValue: [1.5, 2.0, 2.5, 3.5].randomElement()!,
                engineType: engineTypes.randomElement()!,
                type: carTypes.randomElement()!,
                rating: Double(arc4random_uniform(5) + 1),
                coordinates: Coordinates(latitude: Float(location.latitude), longitude: Float(location.longitude)),
                coefficient: Double(arc4random_uniform(100)) / 100.0,
                childSeat: index % 3 == 0
            )
            cars.append(car)
        }
        return cars
    }
}

fileprivate let carsLocations: [Coordinates] = [
    Coordinates(latitude: 55.744389, longitude: 37.598402),
    Coordinates(latitude: 55.739630, longitude: 37.594764),
    Coordinates(latitude: 55.718074, longitude: 37.563780),
    Coordinates(latitude: 55.715957, longitude: 37.571202),
    Coordinates(latitude: 55.717175, longitude: 37.566624),
    Coordinates(latitude: 55.715412, longitude: 37.559088),
    Coordinates(latitude: 55.717597, longitude: 37.576841),
    Coordinates(latitude: 55.723395, longitude: 37.569212),
    Coordinates(latitude: 55.723696, longitude: 37.556933),
    Coordinates(latitude: 55.742048, longitude: 37.595123),
    Coordinates(latitude: 55.744743, longitude: 37.586652),
    Coordinates(latitude: 55.718651, longitude: 37.568095),
    Coordinates(latitude: 55.724193, longitude: 37.557187),
    Coordinates(latitude: 55.726254, longitude: 37.578652),
    Coordinates(latitude: 55.733881, longitude: 37.538283),
    Coordinates(latitude: 55.732776, longitude: 37.537228),
    Coordinates(latitude: 55.843126, longitude: 37.486103),
    Coordinates(latitude: 55.850115, longitude: 37.480832),
    Coordinates(latitude: 55.840922, longitude: 37.461481),
    Coordinates(latitude: 55.840329, longitude: 37.455382),
    Coordinates(latitude: 55.857654, longitude: 37.487533),
    Coordinates(latitude: 55.971617, longitude: 37.452978),
    Coordinates(latitude: 55.970018, longitude: 37.445775),
    Coordinates(latitude: 55.968566, longitude: 37.457891),
    Coordinates(latitude: 55.978824, longitude: 37.387044),
    Coordinates(latitude: 55.930342, longitude: 37.749893),
    Coordinates(latitude: 55.922967, longitude: 37.753279),
    Coordinates(latitude: 55.924097, longitude: 37.757589),
    Coordinates(latitude: 55.922662, longitude: 37.766441),
    Coordinates(latitude: 55.921749, longitude: 37.773823),
    Coordinates(latitude: 55.921536, longitude: 37.765449),
    Coordinates(latitude: 55.917371, longitude: 37.757016),
    Coordinates(latitude: 55.744389, longitude: 37.598402),
    Coordinates(latitude: 55.739630, longitude: 37.594764),
    Coordinates(latitude: 55.742048, longitude: 37.595123),
    Coordinates(latitude: 55.744743, longitude: 37.586652)
]
