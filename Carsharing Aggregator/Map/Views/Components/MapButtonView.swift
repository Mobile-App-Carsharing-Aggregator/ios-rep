//
//  ZoomView.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 10.12.2023.
//

import UIKit
import SnapKit

final class MapButtonView: UIView {
    
    // MARK: - Properties
    
    private let imageButton: UIImage
    private let radiusButton: Double
    private let action: () -> Void
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.carsharing.white90
        view.layer.cornerRadius = radiusButton
        return view
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.carsharing.black
        button.setImage(imageButton, for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - LifeCycle
    
    init(with image: UIImage, radius: Double, action: @escaping () -> Void) {
        self.imageButton = image
        self.radiusButton = radius
        self.action = action
        
        super.init(frame: .zero)
        
        self.addSubviews()
        self.setupLayout()
        
        self.layer.shadowColor = UIColor.carsharing.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(borderView)
        borderView.addSubview(containerView)
        containerView.addSubview(mapButton)
    }
    
    @objc private func mapButtonTapped() {
       action()
    }
    
    private func setupLayout() {
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
