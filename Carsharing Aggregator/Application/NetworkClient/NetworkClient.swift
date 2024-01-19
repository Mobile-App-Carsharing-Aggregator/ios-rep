//
//  NetworkClient.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.12.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int, Data?)
    case urlRequestError(Error)
    case urlSessionError
    case customError(String)
    case decode
}

protocol NetworkClient {
    func send(request: NetworkRequest, onResponse: @escaping (Result<Data, Error>) -> Void) -> NetworkTask?
    
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask?
}

struct DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(session: URLSession, decoder: JSONDecoder, encoder: JSONEncoder) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func send(request: NetworkRequest, onResponse: @escaping (Result<Data, Error>) -> Void) -> NetworkTask? {
        
        guard let urlRequest = create(request: request) else { return nil }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                onResponse(.failure(NetworkError.urlSessionError))
                return
            }
            
            guard 200..<300 ~= response.statusCode else {
                let errorData = data
                onResponse(.failure(NetworkError.httpStatusCode(response.statusCode, errorData)))
                return
            }
            
            if let data {
                onResponse(.success(data))
            } else if let error {
                onResponse(.failure(NetworkError.urlRequestError(error)))
                return
            } else {
                assertionFailure("Unexpected condition!")
                return
            }
        }
        
        task.resume()
        
        return DefaultNetwork(dataTask: task)
    }
    
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask? {
        return send(request: request) { result in
            switch result {
            case let .success(data):
                self.parse(data: data, type: type, onResponse: onResponse)
            case let .failure(error):
                onResponse(.failure(error))
            }
        }
    }
    
    private func create(request: NetworkRequest) -> URLRequest? {
        guard let endpoint = request.endpoint else {
            assertionFailure("Empty endpoint")
            return nil
        }
        
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        if let headers = request.headers {
            headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        }
        
        if let dto = request.dto {
            do {
                let dtoEncoded = try encoder.encode(dto)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = dtoEncoded
            } catch {
                print("Ошибка кодирования DTO: \(error)")
            }
        }
        
        return urlRequest
        
    }
    
    private func parse<T: Decodable>(data: Data, type _: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) {
        do {
            let response = try decoder.decode(T.self, from: data)
            onResponse(.success(response))
        } catch {
            onResponse(.failure(NetworkError.decode))
        }
    }
}
