//
//  FiltersCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import UIKit

final class FiltersCoordinator: ChildCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: MapCoordinator?
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        //selectedFilters -> init
        let viewModel = FiltersViewModel()
        let filtersVC = FiltersViewController(viewModel: viewModel)
        viewModel.coordinator = self
        filtersVC.modalPresentationStyle = .pageSheet
        viewControllerRef?.present(filtersVC, animated: true)
        
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        viewControllerRef?.dismiss(animated: true)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
    }
}
