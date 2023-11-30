//
//  RootCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit

final class RootCoordinator: Coordinator, ParentCoordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingCoordinator = TabBarCoordinator( navigationController: navigationController)
        onboardingCoordinator.parent = self
        addChild(onboardingCoordinator)
        onboardingCoordinator.start()
    }

    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
}
