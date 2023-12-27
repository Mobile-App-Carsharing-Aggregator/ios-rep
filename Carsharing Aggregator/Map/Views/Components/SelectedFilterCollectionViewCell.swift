//
//  SelectedFilterCollectionViewCell.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 19.12.2023.
//

import UIKit
import SnapKit

class SelectedFilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifare = "SelectedFilterCollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.carsharing.black
        return label
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.tintColor = UIColor.carsharing.black
        return image
    }()
    
    private let xmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.closeXsmall
        image.backgroundColor = .clear
        image.tintColor = UIColor.carsharing.black
        return image
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        backgroundColor = .carsharing.green80
        addSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    
    func configure(title: String, star: UIImage?) {
        label.text = title
        starImage.image = star
        setupLayout()
    }
    
    private func addSubview() {
        contentView.addSubview(label)
        contentView.addSubview(starImage)
        contentView.addSubview(xmarkImage)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(xmarkImage.snp.leading).offset(starImage.image != nil ? -18 : -4)
            make.centerY.equalToSuperview()
        }
        xmarkImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(10)
            make.trailing.equalToSuperview().inset(12)
        }
        if starImage.image != nil {
            starImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(10)
                make.trailing.equalToSuperview().inset(26)
            }
        }
    }
}
