//
//  SelectedFilterCollectionViewCell.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 19.12.2023.
//

import UIKit
import SnapKit

class SelectedFilterCollectionViewCell: UICollectionViewCell {
    
    static let identifare = "SelectedFilterCollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.carsharing.black
        return label
    }()
    
    private let xmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.backgroundColor = .clear
        image.isHidden = false
        image.tintColor = UIColor.carsharing.black
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        backgroundColor = .carsharing.green80
        addSubview()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func configure(title: String) {
        label.text = title        
        label.sizeToFit()
    }
    
    private func addSubview() {
        contentView.addSubview(label)
        contentView.addSubview(xmarkImage)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(xmarkImage.snp.leading).offset(-4)
            make.centerY.equalToSuperview()
        }
        
        xmarkImage.snp.makeConstraints { make in
           // make.height.width.equalTo(12)
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}