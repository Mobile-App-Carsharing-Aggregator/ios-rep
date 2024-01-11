//
//  FilterCollectionViewCel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import UIKit
import SnapKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static let identifare = "FilterCollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        addSubview()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isUserInteractionEnabled = true
        backgroundColor = UIColor.carsharing.white90
        layer.borderColor = UIColor.carsharing.black.cgColor
        label.textColor = UIColor.carsharing.black
    }
    
    func configure(title: String, textColor: UIColor? = nil, borderColor: UIColor? = nil, isEnabled: Bool, isSelected: Bool) {
        backgroundColor = .white.withAlphaComponent(0.9)
        label.text = title
        isUserInteractionEnabled = isEnabled
        if isEnabled {
            backgroundColor = isSelected ? UIColor.carsharing.green : UIColor.carsharing.white90
            layer.borderColor = isSelected ? UIColor.carsharing.green.cgColor : UIColor.carsharing.black.cgColor
            label.textColor = UIColor.carsharing.black
        } else {
            backgroundColor = UIColor.carsharing.greyLight
            layer.borderColor = UIColor.carsharing.greyLight.cgColor
            label.textColor = UIColor.carsharing.greyDark
        }
        
        if let borderColor {
            layer.borderColor = borderColor.cgColor
        }
        
        if let textColor {
            label.textColor = textColor
        }
        
        label.sizeToFit()
    }
    
    private func addSubview() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
