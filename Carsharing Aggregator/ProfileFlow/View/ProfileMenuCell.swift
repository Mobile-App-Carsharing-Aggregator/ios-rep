//
//  ProfileMenuCell.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.01.2024.
//

import UIKit
import SnapKit

final class ProfileMenuCell: UITableViewCell {
    // MARK: - Layout elements
    private var itemImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private var transferButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.forward, for: .normal)
        button.tintColor = .carsharing.greyDark
        button.addTarget(ProfileMenuCell.self,
                         action: #selector(didTapTransferButton),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc
    private func didTapTransferButton() {
        
    }
    
    // MARK: - Methods
    func configureCell(with item: ProfileMenuItem) {
        itemImage.image = item.image
        itemLabel.text = item.label
        itemLabel.textColor = item.color
        if !item.transferButton {
            transferButton.isHidden = true
        }
    }
    
    private func setupView() {
        [itemImage, itemLabel, transferButton].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.centerY.equalTo(itemLabel.snp.centerY)
            make.centerX.equalTo(contentView.snp.leading).offset(33)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(57)
        }
        
        transferButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-21)
            make.centerY.equalTo(itemImage.snp.centerY)
        }
    }
}

extension ProfileMenuCell: Reusable {}

enum ProfileMenuItem: CaseIterable {
    case MyMarks
    case SearchHistory
    case Settings
    case Logout
    case DeleteAccount
    
    var color: UIColor {
        switch self {
        case .MyMarks:
            return .carsharing.black
        case .SearchHistory:
            return .carsharing.black
        case .Settings:
            return .carsharing.black
        case .Logout:
            return .carsharing.black
        case .DeleteAccount:
            return .carsharing.red
        }
    }
    
    var image: UIImage {
        switch self {
        case .MyMarks:
            return .starItemMenu ?? UIImage()
        case .SearchHistory:
            return .listItemMenu ?? UIImage()
        case .Settings:
            return .settingsItemMenu ?? UIImage()
        case .Logout:
            return .exitItemMenu ?? UIImage()
        case .DeleteAccount:
            return .deleteItemMenu ?? UIImage()
        }
    }
    
    var label: String {
        switch self {
        case .MyMarks:
            return "Мои оценки"
        case .SearchHistory:
            return "История поиска"
        case .Settings:
            return "Настройки"
        case .Logout:
            return "Выйти из аккаунта"
        case .DeleteAccount:
            return "Удалить аккаунт"
        }
    }
    
    var transferButton: Bool {
        switch self {
        case .MyMarks:
            return true
        case .SearchHistory:
            return true
        case .Settings:
            return true
        case .Logout:
            return false
        case .DeleteAccount:
            return false
        }
    }
    
}
