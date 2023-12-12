//
//  SearchCarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

final class SearchCarCoordinator: ChildCoordinator, ParentCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: MapCoordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let vc = SearchCarViewController()
        viewControllerRef = vc
        let vm = SearchCarViewModel()
        vc.viewModel = vm
        vm.coordinator = self
        navigationController.customPushViewController(
            viewController: vc,
            direction: .fromBottom,
            transitionType: .push
        )
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
}
