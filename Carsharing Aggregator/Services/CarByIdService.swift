//
//  CarByIdService.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 21.01.2024.
//

import Foundation

private struct GetCarByIdRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "http://193.107.238.139/api/v1/cars/" + carId)
    }
    var httpMethod: HttpMethod { .get }
    
    var carId: String
    
    init(carId: String) {
        self.carId = carId
    }
}

final class CarByIdService {
    
    private let networkClient = DefaultNetworkClient(session: .shared, decoder: JSONDecoder(), encoder: JSONEncoder())
    
    func getCar(for carId: String, completion: @escaping (Result<Car, NetworkError>) -> Void) {
        let getCarByIdRequest = GetCarByIdRequest(carId: carId)
        
        networkClient.send(request: getCarByIdRequest, type: Car.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print("error \(error)")
                }
            }
        }
    }
}
