//
//  EmptyProfileViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 21.01.2024.
//

import UIKit
import SnapKit

final class EmptyProfileViewController: UIViewController {
    // MARK: - UI-elements
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.textColor = .carsharing.black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .carsharing.black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self,
                         action: #selector(didTapCloseButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .carsharing.grey
        return image
    }()
    
    private lazy var transferToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти или зарегистрироваться", for: .normal)
        button.titleLabel?.textColor = .carsharing.blue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(didTapTransferToLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Сможете оставлять отзывы, сохранять историю и сравнивать цены разных каршерингов"
        label.textColor = .carsharing.black
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Properties
    var viewModel: ProfileViewModel
    
    // MARK: - Lifecycle
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapTransferToLoginButton() {
        dismiss(animated: true, completion: { [weak self] in
            self?.viewModel.transferToLoginFlow()
        }
        )
    }
    
    // MARK: - Layout Methods
    private func setupUI() {
        view.backgroundColor = .white
        [titleVC, closeButton, avatarImage, transferToLoginButton, descriptionLabel].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleVC.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view).offset(26)
            make.height.equalTo(22)
            make.width.lessThanOrEqualTo(290)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.equalTo(24)
            make.trailing.equalTo(view).offset(-30)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.leading.equalTo(view).offset(21)
            make.top.equalTo(titleVC.snp.bottom).offset(22)
        }
        
        transferToLoginButton.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage.snp.trailing).offset(12)
            make.top.equalTo(avatarImage.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(transferToLoginButton.snp.leading)
            make.trailing.equalTo(view).offset(-21)
            make.top.equalTo(transferToLoginButton.snp.bottom).offset(4)
            make.bottom.equalTo(avatarImage.snp.bottom)
        }
        
    }
}
