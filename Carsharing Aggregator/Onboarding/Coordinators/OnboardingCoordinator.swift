//
//  OnboardingCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit

protocol OnboardingCoordinatorProtocol: AnyObject {
    func showSecondView()
    func startAuthFlow()
    func startMainTabbarFlow()
}

final class OnboardingCoordinator: ChildCoordinator {
    
    weak var delegate: OnboardingCoordinatorDelegate?
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: ParentCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func start() {
        let viewModel = FirstOnboardingViewModel(coordinator: self)
        let viewController = FirstOnboardingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension OnboardingCoordinator: OnboardingCoordinatorProtocol {
    func showSecondView() {
        let viewModel = SecondOnboardingViewModel(coordinator: self)
        let viewController = SecondOnboardingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startAuthFlow() {
        delegate?.startAuthFlow()
    }
    
    func startMainTabbarFlow() {
        parent?.childDidFinish(self)
        delegate?.startTabBarFlow()
    }
    
    func didFinishFlow() {
        parent?.childDidFinish(self)
    }
}

protocol OnboardingCoordinatorDelegate: AnyObject {
    func startAuthFlow()
    func startTabBarFlow()
}
