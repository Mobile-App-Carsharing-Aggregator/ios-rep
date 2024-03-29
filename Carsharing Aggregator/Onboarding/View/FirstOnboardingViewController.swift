//
//  OnboardingViewController.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 27.11.2023.
//

import UIKit
import SnapKit

final class FirstOnboardingViewController: UIViewController {
    
    var viewModel: FirstOnboardingViewModel
    
    // MARK: - UI Elements
    
    private let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.onboardingBackgroundImage
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.onboardingCustomLogo
        return imageView
    }()
    
    private lazy var beginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("ПОГНАЛИ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(beginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: FirstOnboardingViewModel) {
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
        getUser()
    }
    
    // MARK: - Methods
        
    private func setupUI() {
        view.addSubview(backGroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(beginButton)
    }
    
    private func setupLayout() {
        backGroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        beginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-68)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func beginButtonTapped() {
        viewModel.showSecondView()
    }
}

extension FirstOnboardingViewController {
    func getUser() {
        DefaultUserService.shared.getUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Получены данные пользователя: \(user)")
                case .failure(let error):
                    print("Ошибка при получении профиля пользователя: \(error)")
                }
            }
        }
    }
}
