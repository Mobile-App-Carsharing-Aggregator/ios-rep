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
    
    func configure(title: String, textColor: UIColor, borderColor: UIColor) {
        backgroundColor = .white.withAlphaComponent(0.9)
        label.text = title
        layer.borderColor = borderColor.cgColor
        label.textColor = textColor
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
