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
}

final class TabBarView: UIView {
    
    weak var delegate: TabViewDelegate?
   
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.white.withAlphaComponent(1)
        stackView.layer.cornerRadius = 24
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        let customView = TabButtonView(with: UIImage.profile, text: "Профиль")
        button.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton()
        let customView = TabButtonView(with: UIImage.filters, text: "Фильтры")
        button.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var carSearchButton: UIButton = {
        let button = UIButton()
        let customView = TabButtonView(with: UIImage.carSearch, text: "Поиск машины")
        button.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customView.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(carSearchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
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
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func addSubviews() {
        addSubview(borderView)
        borderView.addSubview(actionsStackView)
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
    
    private func setupLayout() {
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filtersButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        profileButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        carSearchButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        actionsStackView.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalToSuperview()
        }
    }
    
    private func configureTabBarStackView() {
        actionsStackView.addArrangedSubview(profileButton)
        actionsStackView.addArrangedSubview(filtersButton)
        actionsStackView.addArrangedSubview(carSearchButton)
    }
}
