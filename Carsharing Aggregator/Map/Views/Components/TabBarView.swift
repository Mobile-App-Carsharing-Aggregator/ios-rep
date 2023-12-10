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
    
    private let buttonWidth = 48
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        stackView.layer.cornerRadius = 24
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage.tabProfile, for: .normal)
//        button.setTitle("Профиль", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        let customView = TabButtonView(with: UIImage.tabProfile, text: "Профиль") {
            <#code#>
        }
        addSubview(customView)
        
        let imageView = UIImageView(image: UIImage.tabProfile)
        let label = UILabel()
        
        customView.addSubview(imageView)
        customView.addSubview(label)
        
        label.text = "Профиль"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        
        imageView.frame = CGRect(x: 4, y: 4, width: 24, height: 24)
        label.frame = CGRect(x: 4, y: 32, width: 24, height: 10)
        
        return button
    }()
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabFilters, for: .normal)
        button.setTitle("Фильтры", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        button.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var carSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.tabCarSearch, for: .normal)
        button.setTitle("Поиск машины", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
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
