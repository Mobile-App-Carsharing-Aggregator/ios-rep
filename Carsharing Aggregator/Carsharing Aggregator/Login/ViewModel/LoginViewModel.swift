//
//  LoginViewModel.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func openRegister()
    func coordinatorDidFinish()
}

class LoginViewModel: LoginViewModelProtocol {
   weak var coordinator: LoginCoordinator?
    
    func openRegister() {
        coordinator?.openRegisterCoordinator()
    }
    
    func coordinatorDidFinish() {
        coordinator?.coordinatorDidFinish()
    }
}
