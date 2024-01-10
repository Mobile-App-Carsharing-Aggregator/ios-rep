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
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .carsharing.greyLight
        layer.cornerRadius = 12
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
        [label].forEach {
            addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(snp.leading).offset(12)
            make.trailing.equalTo(snp.trailing).offset(-12)
        }
    }
}
