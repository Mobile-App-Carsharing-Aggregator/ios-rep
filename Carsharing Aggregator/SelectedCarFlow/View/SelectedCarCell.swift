//
//  SelectedCarCell.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 14.12.2023.
//

import UIKit
import SnapKit

class SelectedCarCell: UICollectionViewCell {
    
    // MARK: - Layout properties
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        addSubview()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Methods
    func configure(title: String) {
        backgroundColor = .carsharing.greyLight
        label.text = title
        label.sizeToFit()
    }
    
    private func addSubview() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
}
