//
//  OnboardingViewModel.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit

protocol FirstOnboardingViewModelProtocol: AnyObject {
    var coordinator: OnboardingCoordinator? { get }
    func showSecondView()
}

final class FirstOnboardingViewModel: FirstOnboardingViewModelProtocol {
    init(coordinator: OnboardingCoordinator?) {
        self.coordinator = coordinator
    }
    weak var coordinator: OnboardingCoordinator?
    
    func showSecondView() {
        coordinator?.showSecondView()
    }
}
