//
//  ProfileCoordinators2.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 30.11.2023.
//

import Foundation

import UIKit

final class ProfileCoordinators2: ParentCoordinator, ChildCoordinator {
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parent: TabBarCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewControllerRef = ProfileViewController2()
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func start() {
        guard let viewControllerRef else { return }
        navigationController.pushViewController(viewControllerRef, animated: true)
    }
}
