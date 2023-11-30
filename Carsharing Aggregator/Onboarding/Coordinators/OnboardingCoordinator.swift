//
//  OnboardingCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit

protocol OnboardingCoordinatorProtocol: AnyObject {
    func showSecondView()
    func completeOnboarding()
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
        var viewController = FirstOnboardingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
}

extension OnboardingCoordinator: OnboardingCoordinatorProtocol {
    func showSecondView() {
        let viewModel = SecondOnboardingViewModel(coordinator: self)
        var viewController = SecondOnboardingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func completeOnboarding() {
        parent?.childDidFinish(self)
        delegate?.startTabBarFlow()
    }
}

protocol OnboardingCoordinatorDelegate: AnyObject {
    func startTabBarFlow()
}
