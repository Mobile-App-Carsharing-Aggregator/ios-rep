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
        let vm = SearchCarViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        vc.modalPresentationStyle = .pageSheet
        viewControllerRef?.present(vc, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
    }
    
}
