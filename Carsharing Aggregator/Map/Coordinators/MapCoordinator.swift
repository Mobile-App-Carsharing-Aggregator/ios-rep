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
        mapVC.modalPresentationStyle = .overFullScreen
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(mapVC, animated: true)
    }
    
    func openProfile(on vc: UIViewController) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.parent = self
        addChild(profileCoordinator)
        profileCoordinator.viewControllerRef = vc
        profileCoordinator.start()
    }

    func openFilters(on vc: UIViewController, selectedFilters: [ListSection: [ListItem]], viewModel: MapViewModel) {
        let filtersCoordinator = FiltersCoordinator(navigationController: navigationController, selectedFilters: selectedFilters, mapModel: viewModel)
        filtersCoordinator.parent = self
        addChild(filtersCoordinator)
        filtersCoordinator.viewControllerRef = vc
        filtersCoordinator.start()
    }
    
    func openSearchCar(on vc: UIViewController) {
        let searchCarCoordinator = SearchCarCoordinator(navigationController: navigationController)
        searchCarCoordinator.parent = self
        addChild(searchCarCoordinator)
        searchCarCoordinator.viewControllerRef = vc
        searchCarCoordinator.start()
    }
    
    func openCar(on vc: UIViewController, with car: Car) {
        let selectedCarCoordinator = SelectedCarCoordinator(navigationController: navigationController, selectedCar: car)
        selectedCarCoordinator.parent = self
        addChild(selectedCarCoordinator)
        selectedCarCoordinator.viewControllerRef = vc
        selectedCarCoordinator.start()
    }
    
    func openReviewAndRating(on vc: UIViewController) {
        let defaults = UserDefaults.standard
        if let car = defaults.dictionary(forKey: "car") {
            let ratingCoordinator = ReviewAndRatingCordinator(navigationController: navigationController)
            
            addChild(ratingCoordinator)
            ratingCoordinator.delegate = self
            ratingCoordinator.viewControllerRef = vc
            ratingCoordinator.start()
        }
    }
}

extension MapCoordinator: ReviewAndRatingCordinatorDelegate {
    func showRatingAlert() {
        let alert = UIAlertController(title: "Спасибо за отзыв!",
                                      message: "Он поможет другим \n пользователям сделать \n выбор",
                                      preferredStyle: .alert)
        navigationController.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
