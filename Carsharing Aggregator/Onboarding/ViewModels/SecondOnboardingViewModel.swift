//
//  SecondOnboardingViewControllerViewModel.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 30.11.2023.
//

import Foundation

protocol SecondOnboardingViewModelProtocol: AnyObject {
    var coordinator: OnboardingCoordinator? { get set }
    func completeOnboarding()
}

final class SecondOnboardingViewModel: SecondOnboardingViewModelProtocol {
    weak var coordinator: OnboardingCoordinator?
    
    init(coordinator: OnboardingCoordinator?) {
        self.coordinator = coordinator
    }
    
    func completeOnboarding() {
        coordinator?.completeOnboarding()
    }
}
