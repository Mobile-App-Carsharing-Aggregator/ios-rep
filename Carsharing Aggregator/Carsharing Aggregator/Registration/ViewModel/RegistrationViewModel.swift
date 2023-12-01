//
//  RegistrationViewModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import Foundation


class RegistrationViewModel {
    weak var coordinator: RegistrationCoordinator?
    
    func openDocumentsCoordinator() {
        
        coordinator?.openDocumentsCoordinator()
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
}
