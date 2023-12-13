//
//  SelectedCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import UIKit
import SnapKit

final class SelectedCarViewController: UIViewController {
    
    //MARK: - Layout properties
    
    //MARK: - Properties
    var viewModel: SelectedCarViewModel
    
    //MARK: - LifeCycle
    init(viewModel: SelectedCarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //MARK: - Actions
    
    //MARK: - Methods
    
}
