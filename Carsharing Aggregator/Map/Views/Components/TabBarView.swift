//
//  TabBarView.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 27.11.2023.
//

import UIKit
import SnapKit

protocol TabViewDelegate: AnyObject {
    func profileButtonTapped()
    func filtersButtonTapped()
    func carSearchButtonTapped()
    func orderButtonTapped()
    func locationButtonTapped()
}

final class TabBarView: UIView {
    
    weak var delegate: TabViewDelegate?
    
    private let buttonWidth = 56
    
    private lazy var locationContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.roundCorners([.topLeft, .bottomLeft], radius: 4)
        return view
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        stackView.roundCorners([.topRight, .bottomRight], radius: 4)
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabProfile, for: .normal)
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabFilters, for: .normal)
        button.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var carSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabCarSearch, for: .normal)
        button.addTarget(self, action: #selector(carSearchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabOrder, for: .normal)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.locationButton, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.addSubviews()
        self.setupLayout()
        self.configureTabBarStackView()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func addSubviews() {
        addSubview(borderView)
        borderView.addSubview(actionsStackView)
        borderView.addSubview(locationContainerView)
        locationContainerView.addSubview(locationButton)
    }
    
    @objc private func profileButtonTapped() {
        delegate?.profileButtonTapped()
    }
    @objc private func filtersButtonTapped() {
        delegate?.filtersButtonTapped()
    }
    @objc private func carSearchButtonTapped() {
        delegate?.carSearchButtonTapped()
    }
    @objc private func orderButtonTapped() {
        delegate?.orderButtonTapped()
    }
    @objc private func locationButtonTapped() {
        delegate?.locationButtonTapped()
    }
    
    private func setupLayout() {
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        locationContainerView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(locationContainerView)
        }
        
        actionsStackView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(locationContainerView.snp.leading).offset(-2)
        }
    }
    
    private func configureTabBarStackView() {
        actionsStackView.addArrangedSubview(profileButton)
        actionsStackView.addArrangedSubview(filtersButton)
        actionsStackView.addArrangedSubview(carSearchButton)
        actionsStackView.addArrangedSubview(orderButton)
    }
}
