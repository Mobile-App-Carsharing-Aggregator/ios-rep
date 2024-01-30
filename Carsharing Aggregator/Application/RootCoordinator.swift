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
        if TokenStorage.shared.getToken() != nil {
            let tabBarCoordinator = MapCoordinator( navigationController: navigationController)
            tabBarCoordinator.parent = self
            addChild(tabBarCoordinator)
            navigationController.viewControllers = []
            tabBarCoordinator.start()
        } else {
            let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
            onboardingCoordinator.parent = self
            onboardingCoordinator.delegate = self
            addChild(onboardingCoordinator)
            onboardingCoordinator.start()
        }
    }
    
    func openAuthCoordinator() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parent = self
        addChild(authCoordinator)
        authCoordinator.start()
    }
}

extension RootCoordinator: OnboardingCoordinatorDelegate {
    func startAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parent = self
        addChild(authCoordinator)
        authCoordinator.start()
    }
    
    func startTabBarFlow() {
        let tabBarCoordinator = MapCoordinator( navigationController: navigationController)
        tabBarCoordinator.parent = self
        addChild(tabBarCoordinator)
        navigationController.viewControllers = []
        tabBarCoordinator.start()
    }
}
