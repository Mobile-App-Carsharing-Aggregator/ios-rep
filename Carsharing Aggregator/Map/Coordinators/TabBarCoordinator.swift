//
//  TabBarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 28.11.2023.
//

import UIKit

final class TabBarCoordinator: ParentCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
      
    }
}
