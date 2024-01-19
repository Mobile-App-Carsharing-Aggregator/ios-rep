//
//  ReviewsViewController.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 19.01.2024.
//

import UIKit
import SnapKit

final class ReviewsViewController: UIViewController {
    
    // MARK: - Layout properties
    
    // MARK: - Properties
    var viewModel: ReviewsViewModel
    
    // MARK: - LifeCycle
    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    
}
