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
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parent = self
        addChild(authCoordinator)
        authCoordinator.start()
    }
}
