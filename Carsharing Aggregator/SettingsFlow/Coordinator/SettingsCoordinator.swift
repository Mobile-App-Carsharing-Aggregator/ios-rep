//
//  SettingsCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 21.01.2024.
//

import UIKit

final class SettingsCoordinator: ChildCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    weak var parent: ProfileCoordinator?
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        viewModel.coordinator = self
        
        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { _ in
                    return  496
                })]
            } else {
                sheet.detents = [.large()]
            }
            
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
  
        viewControllerRef?.present(viewController, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        viewControllerRef?.dismiss(animated: true)
    }
}
