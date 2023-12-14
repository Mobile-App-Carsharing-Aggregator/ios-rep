//
//  SelectedCarRatingCell.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 14.12.2023.
//

import UIKit
import SnapKit

class SelectedCarRatingCell: UICollectionViewCell {
    
    // MARK: - Layout properties
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .carsharing.black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let star: UIImageView = {
        let star = UIImageView()
        star.contentMode = .scaleAspectFit
        star.image = UIImage.starRating
        return star
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
    }
    
    private func addSubview() {
        contentView.addSubview(label)
        contentView.addSubview(star)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(8)
            make.centerY.equalToSuperview()
        }
        
        star.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(10)
            make.leading.equalTo(label.snp.trailing).offset(4)
        }
    }
}
