//
//  MapCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 28.11.2023.
//

import UIKit

final class MapCoordinator: ParentCoordinator, ChildCoordinator {
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parent: RootCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func start() {
        let viewModel = MapViewModel()
        let mapVC = MapViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(mapVC, animated: true)
    }
    
    func openProfile() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.parent = self
        addChild(profileCoordinator)
        profileCoordinator.start()
    }
    
    func openFilters(on vc: UIViewController) {
        let filtersCoordinator = FiltersCoordinator(navigationController: navigationController)
        filtersCoordinator.parent = self
        addChild(filtersCoordinator)
        filtersCoordinator.viewControllerRef = vc
        filtersCoordinator.start()
    }
}