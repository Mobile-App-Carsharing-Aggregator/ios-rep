//
//  NetworkTask.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.12.2023.
//

import Foundation

protocol NetworkTask {
    func cancel()
}

struct DefaultNetwork: NetworkTask {
    let dataTask: URLSessionDataTask
    
    func cancel() {
        dataTask.cancel()
    }
}
