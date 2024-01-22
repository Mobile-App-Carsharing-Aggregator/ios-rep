//
//  CarModelCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 22.01.2024.
//

import UIKit

final class CarModelCoordinator: ChildCoordinator {
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    weak var parent: SearchCarCoordinator?
    var selectedCarModel: CarModel
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController, selectedCarModel: CarModel) {
        self.navigationController = navigationController
        self.selectedCarModel = selectedCarModel
    }
    
    // MARK: - Methods
    func start() {
        let viewModel = CarModelViewModel()
        let viewController = CarModelViewController()
        viewController.viewModel = viewModel
        viewModel.coordinator = self
        let sheetHeight = { [self] in
            switch selectedCarModel.companies.count {
            case 1:
                return 316
            case 2:
                return 384
            case 3:
                return 452
            case 4:
                return 520
            default:
                return 520
            }
        }
      
        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { context in
                    return  CGFloat(sheetHeight())
                })]
            } else {
                /* need customize for iOS <16 */
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
