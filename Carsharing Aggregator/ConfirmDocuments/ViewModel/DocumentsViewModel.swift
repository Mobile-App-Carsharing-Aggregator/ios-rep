//
//  DocumentsViewModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 01.12.2023.
//

import Foundation


class DocumentsViewModel {
    weak var coordinator: DocumentCoordinator?
    
    func openTabBarController() {
        
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
    
}
