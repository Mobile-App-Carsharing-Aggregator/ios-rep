//
//  TabBarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 28.11.2023.
//

import UIKit

final class TabBarCoordinator: ParentCoordinator, ChildCoordinator {
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parent: RootCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func start() {
        let tabBarVC = TabBarViewController()
        viewControllerRef = tabBarVC
        tabBarVC.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(tabBarVC, animated: false)
    }
}
