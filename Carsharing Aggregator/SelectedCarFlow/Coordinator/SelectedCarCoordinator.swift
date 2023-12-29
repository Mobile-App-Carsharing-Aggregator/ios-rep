//
//  SelectedCarCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import UIKit

final class SelectedCarCoordinator: ChildCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    weak var parent: MapCoordinator?
    var selectedCar: Car
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController, selectedCar: Car) {
        self.navigationController = navigationController
        self.selectedCar = selectedCar
    }
    
    // MARK: - Methods
    func start() {
        let viewModel = SelectedCarViewModel(selectedCar: selectedCar)
        let viewController = SelectedCarViewController(viewModel: viewModel)
        viewModel.coordinator = self
        let navVC = UINavigationController(rootViewController: viewController)
        
        if let sheet = navVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { context in
                    return  527
                })]
            } else {
                // TODO: - customize for iOS <16
                sheet.detents = [.medium()]
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
