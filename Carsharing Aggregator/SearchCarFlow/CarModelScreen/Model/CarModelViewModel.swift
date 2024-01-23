//
//  CarModelViewModel.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 22.01.2024.
//

import UIKit

final class CarModelViewModel {
    
    // MARK: - Observables
    @Observable
    private (set) var carModel: CarModel?
    
    // MARK: - Properties
    weak var coordinator: CarModelCoordinator?
    
    // MARK: - Methods
    func viewWillAppear() {
       getCarModel()
    }
    
    func didTapCloseButton() {
        coordinator?.parent?.coordinatorDidFinish()
    }
    
    func transferToCarshering(company: CarsharingCompany) {
        let appStoreURL = URL(string: "https://apps.apple.com/app/id\(company.appStoreID)")!
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    private func getCarModel() {
        carModel = coordinator?.selectedCarModel
    }
}
