//
//  ProfileCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import UIKit

final class ProfileCoordinator: ChildCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: ParentCoordinator?
    
    // MARK: - LifeCycle
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let profileVC = ProfileViewController()
        viewControllerRef = profileVC
        profileVC.coordinator = self
        navigationController.customPushViewController(
            viewController: profileVC,
            direction: .fromBottom,
            transitionType: .push
        )
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
    
}
