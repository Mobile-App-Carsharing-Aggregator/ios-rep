//
//  ReviewAndRatingCordinator.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 16.01.2024.
//

import UIKit

protocol ReviewAndRatingCordinatorDelegate: AnyObject {
    func showRatingAlert()
}

final class ReviewAndRatingCordinator: ChildCoordinator {
    // MARK: - Properties
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    var parent: RootCoordinator?
    var sheet: UISheetPresentationController?
    weak var delegate: ReviewAndRatingCordinatorDelegate?
    
    // MARK: - LifeCycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let defaults = UserDefaults.standard
        let viewModel = ReviewAndRatingViewModel()
        let reviewVC = ReviewAndRatingViewController(viewModel: viewModel)
        reviewVC.delegate = self
        viewModel.coordinator = self
        
        if let car = defaults.dictionary(forKey: "car") as? [String: String] {
                viewModel.modelCar = car["model"] ?? ""
                if let sheet = reviewVC.sheetPresentationController {
                    if #available(iOS 16.0, *) {
                        sheet.detents = [.custom(resolver: { _ in
                            return  309
                        })]
                    } else {
                        sheet.detents = [.medium()]
                    }
                    sheet.prefersGrabberVisible = true
                    sheet.largestUndimmedDetentIdentifier = .medium
                    self.sheet = sheet
                }
                viewControllerRef?.present(reviewVC, animated: true)
            }
        }
    
    func coordinatorDidFinish() {
        viewControllerRef?.dismiss(animated: true)
        parent?.childDidFinish(self)
    }
    
    func showRatingAlert() {
        delegate?.showRatingAlert()
    }
}

extension ReviewAndRatingCordinator: ReviewAndRatingViewControllerDelegate {
    func commentViewOpened() {
        if #available(iOS 16.0, *) {
            sheet?.detents = [.custom(resolver: { _ in
                return  374
            })]
        } else {
            sheet?.detents = [.medium()]
        }
    }
}
