//
//  TabButtonView.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 10.12.2023.
//

import UIKit
import SnapKit

final class TabButtonView: UIView {
    
    private let imageButton: UIImage
    private let textLabel: String
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: imageButton)
        return imageView
    }()
    
    private lazy var titleButton: UILabel = {
        let title = UILabel()
        title.text = textLabel
        title.font = .systemFont(ofSize: 10, weight: .semibold)
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    init(with image: UIImage, text: String) {
        self.imageButton = image
        self.textLabel = text
        
        super.init(frame: .zero)
        
        self.addSubviews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleButton)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
            make.top.equalToSuperview().offset(10)
        }
        titleButton.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.height.equalTo(12)
            make.top.equalTo(imageView.snp.bottom).offset(2)
        }
    }
}
