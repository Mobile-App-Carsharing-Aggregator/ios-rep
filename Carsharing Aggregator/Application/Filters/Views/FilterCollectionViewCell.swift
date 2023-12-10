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
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 24
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
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
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
