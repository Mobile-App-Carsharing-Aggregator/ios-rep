//
//  OnboardingCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit

final class OnboardingCoordinator: ChildCoordinator {

    
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: ParentCoordinator?
    
    init(viewControllerRef: UIViewController, navigationController: UINavigationController) {
        self.viewControllerRef = viewControllerRef
        self.navigationController = navigationController
    }
    
    func coordinatorDidFinish() {
        
    }

    func start() {
        guard let viewControllerRef else { return }
        navigationController.pushViewController(viewControllerRef, animated: true)
    }
}
