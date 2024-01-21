//
//  ProfileCoordinator.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import UIKit

final class ProfileCoordinator: ChildCoordinator, ParentCoordinator {
    
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    weak var parent: MapCoordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - LifeCycle
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let viewModel = ProfileViewModel()
        viewModel.coordinator = self
        let view: UIViewController?
        var sheetHeight: CGFloat
        if viewModel.checkProfile() {
            view = ProfileViewController(viewModel: viewModel)
            sheetHeight = 462
        } else {
            view = EmptyProfileViewController(viewModel: viewModel)
            sheetHeight = 189
        }
        guard let viewController = view else { return }
        
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { _ in
                    return sheetHeight
                })]
            } else {
                /* need customize for iOS <16 */
            }
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        viewControllerRef?.present(viewController, animated: true)
    }
    
    func openReviews(on vc: UIViewController) {
        let reviewsCoordinator = ReviewsCoordinator(navigationController: navigationController)
        reviewsCoordinator.parent = self
        addChild(reviewsCoordinator)
        reviewsCoordinator.viewControllerRef = vc
        reviewsCoordinator.start()
    }
    
    func openSettings(on vc: UIViewController) {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        settingsCoordinator.parent = self
        addChild(settingsCoordinator)
        settingsCoordinator.viewControllerRef = vc
        settingsCoordinator.start()
    }
    
    func openSearchHistory(on vc: UIViewController) {
        let searchHistoryCoordinator = SearchHistoryCoordinator(navigationController: navigationController)
        searchHistoryCoordinator.parent = self
        addChild(searchHistoryCoordinator)
        searchHistoryCoordinator.viewControllerRef = vc
        searchHistoryCoordinator.start()
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
    }
}
