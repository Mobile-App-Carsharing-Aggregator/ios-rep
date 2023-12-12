//
//  PrepareBookingCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 12.12.2023.
//

import UIKit
import SnapKit

final class PrepareBookingCarViewController: UIViewController {
    // MARK: - UI
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.backward"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var closeButton = UIBarButtonItem(
        image: UIImage(named: "closeLightGrey"),
        style: .plain,
        target: self,
        action: #selector(didTapCloseButton)
    )
    
    private lazy var carImage: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        return stack
    }()
    
    private lazy var carTypeLabel: UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    private lazy var carRatingView: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    
    // MARK: - Properties
    
    var car: Car?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
    }
    
    
    // MARK: - Methods
    
    
    // MARK: - Layout Methods
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
        guard let car = car else { return }
        title = car.name + " " + car.model
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [carImage, vStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupNavBar()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        
    }
    
    @objc
    private func didTapCloseButton() {
        
    }
}

