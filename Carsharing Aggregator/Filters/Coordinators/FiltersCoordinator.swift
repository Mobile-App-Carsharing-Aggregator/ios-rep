//
//  FiltersCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//
import UIKit

final class FiltersCoordinator: ChildCoordinator {
    
    // MARK: - Properties
    var selectedFilters: [ListSection: [ListItem]]
    var mapModel: MapViewModel
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: MapCoordinator?
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController, selectedFilters: [ListSection: [ListItem]], mapModel: MapViewModel) {
        self.navigationController = navigationController
        self.selectedFilters = selectedFilters
        self.mapModel = mapModel
    }
    
    // MARK: - Methods
    func start() {
        let viewModel = FiltersViewModel()
        viewModel.selectedFilters = selectedFilters
        let filtersVC = FiltersViewController(viewModel: viewModel)
        filtersVC.delegate = mapModel
        viewModel.coordinator = self
        filtersVC.modalPresentationStyle = .pageSheet
        if let sheet = filtersVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { context in
                    return heightLargeSheet
                })]
            } else {
                sheet.detents = [.large()]
            }
            
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
  
        viewControllerRef?.present(filtersVC, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        viewControllerRef?.dismiss(animated: true)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
    }
}
