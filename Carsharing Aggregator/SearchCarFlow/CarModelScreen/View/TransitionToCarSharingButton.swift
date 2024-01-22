//
//  TransitionToCarSharingButton.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 13.12.2023.
//
import UIKit
import SnapKit

final class TransitionToCarSharingButton: UIView {
    // MARK: - Layout properties
    private var bookingLabel: UILabel = {
        let label = UILabel()
        label.text = "ЗАБРОНИРОВАТЬ"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .carsharing.black
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .carsharing.greyDark
        return label
    }()
    
    private var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        stack.alignment = .center
        return stack
    }()
    
    private lazy var logo: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var carsharingCompany: CarsharingCompany?
    
    // MARK: - Actions
    @objc
    private func didTapLink(sender: UIGestureRecognizer) {
        guard let company = carsharingCompany else { return }
        let appStoreURL = URL(string: "https://apps.apple.com/app/id\(company.appStoreID)")!
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    // MARK: - Methods
    func configure(with company: CarsharingCompany) {
        carsharingCompany = company
        priceLabel.text = "\(company.name) от \(company.price)₽/мин"
        logo.image = company.bigIcon
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(didTapLink))
                                  )
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.borderWidth = 2
        layer.borderColor = (UIColor.carsharing.black).cgColor
        
        [labelsStack, logo].forEach {
            addSubview($0)
        }
        
        labelsStack.addArrangedSubview(bookingLabel)
        labelsStack.addArrangedSubview(priceLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(16)
            make.centerY.equalTo(snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        labelsStack.snp.makeConstraints { make in
            make.centerY.equalTo(logo.snp.centerY)
            make.leading.equalTo(logo.snp.trailing)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
}
