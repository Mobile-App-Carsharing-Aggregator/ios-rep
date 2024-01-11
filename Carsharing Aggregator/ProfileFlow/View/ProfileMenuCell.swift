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
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc
    private func didTapTransferButton() {
        
    }
    
    //MARK: - Methods
    func configureCell(with item: ProfileMenuItem) {
        itemImage.image = item.image
        itemLabel.text = item.label
        itemLabel.textColor = item.color
        if !item.transferButton {
            transferButton.isHidden = true
        }
    }
    
    private func setView() {
        [itemImage, itemLabel, transferButton].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        itemImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.top.equalTo(contentView.snp.top).offset(4)
            make.bottom.equalTo(contentView.snp.bottom).offset(-4)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.leading.equalTo(itemImage.snp.trailing).offset(12)
            make.centerY.equalTo(itemImage.snp.centerY)
        }
        
        transferButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing)
            make.centerY.equalTo(itemImage.snp.centerY)
        }
    }
}

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
            return .starRating ?? UIImage()
        case .SearchHistory:
            return .starRating ?? UIImage()
        case .Settings:
            return .starRating ?? UIImage()
        case .Logout:
            return .starRating ?? UIImage()
        case .DeleteAccount:
            return .starRating ?? UIImage()
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
