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
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.parent = self
        onboardingCoordinator.delegate = self
        addChild(onboardingCoordinator)
        onboardingCoordinator.start()
    }

    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
}

extension RootCoordinator: OnboardingCoordinatorDelegate {
    func startTabBarFlow() {
        let tabBarCoordinator = TabBarCoordinator( navigationController: navigationController)
        tabBarCoordinator.parent = self
        addChild(tabBarCoordinator)
        navigationController.viewControllers = []
        tabBarCoordinator.start()
    }
}
