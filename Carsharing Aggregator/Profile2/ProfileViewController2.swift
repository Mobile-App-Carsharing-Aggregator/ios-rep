//
//  ProfileViewController2.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 30.11.2023.
//

import UIKit

final class ProfileViewController2: UIViewController {
    weak var coordinator: ProfileCoordinators2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    func cleanUp() {
        coordinator?.coordinatorDidFinish()
    }
}
