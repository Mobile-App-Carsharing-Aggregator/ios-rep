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
        let enterViewModel = EnterViewModel(coordinator: self)
        let loginVC = EnterViewController(enterViewModel: enterViewModel)
        enterViewModel.coordinator = self
        navigationController.setAttributesForCarsharingTitle(loginVC: loginVC)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func startTabBarFlow() {
        parent?.finishAuthAndStartTabBarFlow()
    }
    
}
