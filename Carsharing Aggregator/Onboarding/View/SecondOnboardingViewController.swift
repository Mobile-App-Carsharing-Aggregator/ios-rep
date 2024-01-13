//
//  SecondOnboardingViewController.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 30.11.2023.
//

import UIKit
import SnapKit

final class SecondOnboardingViewController: UIViewController {
    
    var viewModel: SecondOnboardingViewModelProtocol
    
    // MARK: - UI Elements
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.onboardingCustomLogoSecond
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "найдите идеальный\nавто для каждого мгновения"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.setTitle("Пропустить", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: SecondOnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    deinit {
        viewModel.vcDeinit()
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
        view.addSubview(textLabel)
        view.addSubview(loginButton)
        view.addSubview(skipButton)
    }
    
    private func setupLayout() {
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(skipButton.snp.top).offset(-20)
            make.height.equalTo(50)
        }
        
        skipButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-68)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
    
    @objc
    private func skipButtonTapped() {
        viewModel.skipButtonTapped()
    }
}
