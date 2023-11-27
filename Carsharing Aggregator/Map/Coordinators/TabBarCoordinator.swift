//
//  TabBarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 28.11.2023.
//

import UIKit

final class TabBarCoordinator: ParentCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(childCoordinators: [Coordinator], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
    
    func start() {
        
    }
    
    
}
