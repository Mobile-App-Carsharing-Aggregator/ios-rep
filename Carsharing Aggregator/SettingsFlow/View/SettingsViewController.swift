//
//  SettingsViewController.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 21.01.2024.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    // MARK: - Layout properties
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Coming soon"
        placeholderLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return placeholderLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Настройки"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .carsharing.black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .carsharing.greyDark
        button.addTarget(self,
                         action: #selector(didTapBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem()
        closeButton.image = UIImage(systemName: "xmark")?.withTintColor(.carsharing.greyDark)
        closeButton.style = .plain
        closeButton.target = self
        closeButton.action = #selector(didTapCloseButton)
        return closeButton
    }()
    
    // MARK: - Properties
    var viewModel: SettingsViewModel
    
    // MARK: - LifeCycle
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc
    private func didTapCloseButton() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeButton
        navigationController?.navigationBar.tintColor = .carsharing.black
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = false
        
        [placeholderLabel, titleLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
            make.height.equalTo(22)
        }
    }
}

