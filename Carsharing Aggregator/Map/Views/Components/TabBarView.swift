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
    
    // MARK: - Properties
    
    weak var delegate: TabViewDelegate?
    private let imageFilter: UIImage
    private let titleFilter: String
    
    // MARK: - UI
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.carsharing.white90
        stackView.layer.cornerRadius = 30
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        let customView = TabButtonView(with: UIImage.tabProfile ?? UIImage(), text: "Профиль")
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
        let customView = TabButtonView(with: imageFilter, text: titleFilter)
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
        let customView = TabButtonView(with: UIImage.tabCarSearch ?? UIImage(), text: "Поиск машины")
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
    
    // MARK: - LifeCycle
    
    init(with imageFilter: UIImage, titleFilter: String) {
        self.imageFilter = imageFilter
        self.titleFilter = titleFilter
        
        super.init(frame: .zero)
        self.addSubviews()
        self.setupLayout()
        self.configureTabBarStackView()
        
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
            make.edges.equalToSuperview()
        }
    }
    
    private func configureTabBarStackView() {
        actionsStackView.addArrangedSubview(profileButton)
        actionsStackView.addArrangedSubview(filtersButton)
        actionsStackView.addArrangedSubview(carSearchButton)
    }
}
