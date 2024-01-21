//
//  SearchHistoryViewController.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 21.01.2024.
//

import UIKit
import SnapKit

final class SearchHistoryViewController: UIViewController {
    
    // MARK: - Layout properties
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Coming soon"
        placeholderLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return placeholderLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "История поиска"
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
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .carsharing.greyDark
        closeButton.addTarget(self,
                              action: #selector(didTapCloseButton),
                              for: .touchUpInside)
        return closeButton
    }()
    
    // MARK: - Properties
    var viewModel: SearchHistoryViewModel
    
    // MARK: - LifeCycle
    init(viewModel: SearchHistoryViewModel) {
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
        
        [placeholderLabel, titleLabel, closeButton, backButton].forEach {
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
        
        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-21)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.width.equalTo(24)
            make.leading.equalToSuperview().offset(30)
        }
    }
}
