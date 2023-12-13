//
//  RatingCollectionViewCell.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 09.12.2023.
//

import UIKit
import SnapKit

class RatingCollectionViewCell: UICollectionViewCell {
    
    static let identifare = "RatingCollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let star: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    func configure(title: String, image: String, borderColor: UIColor, background: UIColor) {
        label.text = title
        star.image = UIImage(named: image)
        layer.borderColor = borderColor.cgColor
        backgroundColor = background
    }
    
    private func addSubview() {
        contentView.addSubview(label)
        contentView.addSubview(star)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        star.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(24)
            make.leading.equalTo(label.snp.trailing).offset(8)
        }
    }
}
