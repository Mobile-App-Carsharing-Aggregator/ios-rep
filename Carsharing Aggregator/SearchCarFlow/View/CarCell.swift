//
//  CarCell.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit
import SnapKit

final class CarCell: UICollectionViewCell {
    
    // MARK: - Layout
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .carsharing.black
        return label
    }()
    
    // MARK: - Properties
    var carModel: Car?
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Methods
    func configure(with model: Car) {
        carModel = model
        imageView.image = UIImage(systemName: "car.front.waves.up.fill")
        nameLabel.text = model.name + " " + model.model
    }
    
    // MARK: - Layout methods
    func setupView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.carsharing.greyMedium.cgColor
        
        [imageView, nameLabel].forEach {
            contentView.addSubview($0)
        }
        
        setConstraints()
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(12)
            make.size.equalTo(CGSize(width: 96, height: 60))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-14)
        }
    }
}
