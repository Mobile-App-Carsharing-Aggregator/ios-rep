//
//  SearchHistoryCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 21.01.2024.
//

import Foundation

import UIKit

final class SearchHistoryCoordinator: ChildCoordinator {
    
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
        let viewModel = SearchHistoryViewModel()
        let viewController = SearchHistoryViewController(viewModel: viewModel)
        viewModel.coordinator = self
        let navVC = UINavigationController(rootViewController: viewController)
        
        if let sheet = navVC.sheetPresentationController {
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
  
        viewControllerRef?.present(navVC, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
        viewControllerRef?.dismiss(animated: true)
    }
}
