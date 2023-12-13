//
//  SelectedCarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import UIKit

final class SelectedCarCoordinator: ChildCoordinator {
    
    //MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    weak var parent: MapCoordinator?
    
    //MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Methods
    func start() {
        
        let viewModel = SelectedCarViewModel()
        let viewController = SelectedCarViewController(viewModel: viewModel)
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        viewControllerRef?.present(viewController, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        viewControllerRef?.dismiss(animated: true)
    }
}
