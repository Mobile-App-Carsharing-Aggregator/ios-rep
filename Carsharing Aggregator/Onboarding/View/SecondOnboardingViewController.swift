//
//  SecondOnboardingViewController.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 30.11.2023.
//

import UIKit
import SnapKit

final class SecondOnboardingViewController: UIViewController {
    
    var viewModel: SecondOnboardingViewModel
    
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.onboardingCustomLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "найдите идеальный\nавто для каждого\nмгновения"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Продолжить", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(beginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: SecondOnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    // MARK: - Methods
        
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(continueButton)
        view.addSubview(textLabel)
    }
    
    private func setupLayout() {
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(220)
            make.leading.trailing.equalToSuperview().inset(44)
            make.height.equalTo(158)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(44)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-68)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func beginButtonTapped() {
        viewModel.completeOnboarding()
    }
}
