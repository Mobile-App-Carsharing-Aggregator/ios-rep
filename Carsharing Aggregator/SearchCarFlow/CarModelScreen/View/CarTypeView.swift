//
//  CarTypeView.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 08.01.2024.
//

import UIKit
import SnapKit

class CarTypeView: UIView {
    
    // MARK: - Layout properties
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .carsharing.black
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    private let icon: UIImageView = {
        let star = UIImageView()
        star.contentMode = .scaleAspectFit
        star.image = UIImage.car
        return star
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(title: String) {
        label.text = title
    }
    
    private func setupView() {
        backgroundColor = .carsharing.greyLight
        layer.cornerRadius = 12
        [icon, label].forEach {
            addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        icon.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(12)
            make.centerY.equalTo(snp.centerY)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(4)
            make.trailing.equalTo(snp.trailing).offset(-12)
        }
    }
}
