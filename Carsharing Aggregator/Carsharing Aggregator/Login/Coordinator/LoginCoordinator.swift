//
//  LoginCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Greg on 29.11.2023.
//

import UIKit


class LoginCoordinator: ChildCoordinator, Coordinator {
    var viewControllerRef: UIViewController?
    weak var parent: AuthCoordinator?
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewModel = LoginViewModel()
        let loginVC = LoginViewController(loginViewModel: loginViewModel)
        loginViewModel.coordinator = self
        navigationController.setAttributesForCarsharingTitle(loginVC: loginVC)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func openRegisterCoordinator() {
        parent?.openRegisterCoordinator()
    }
    
}
