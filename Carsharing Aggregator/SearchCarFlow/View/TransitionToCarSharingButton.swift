//
//  TransitionToCarSharingButton.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 13.12.2023.
//
import UIKit
import SnapKit

final class TransitionToCarSharingButton: UIView {
    
    //MARK: - Layout properties
    
    private var bookingLabel: UILabel = {
        let label = UILabel()
        label.text = "Забронировать"
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
    
    //MARK: - Properties
    
//    weak var delegate: TransitionToCarSharingButtonDelegate?
    
    // MARK: - Actions
    
    @objc
    private func didTapButton() {

    }
    
    //MARK: - Methods
    
    func configure(with company: String, companyLogo: UIImage) {
        priceLabel.text = company + " " + "от 7 ₽/мин"
        logo.image = companyLogo
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.borderWidth = 2
        layer.borderColor = (UIColor.carsharing.black).cgColor
        frame.size.height = 52
        
        [labelsStack, logo].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        labelsStack.addArrangedSubview(bookingLabel)
        labelsStack.addArrangedSubview(priceLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        logo.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(16)
            make.centerY.equalTo(snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        labelsStack.snp.makeConstraints { make in
            make.centerY.equalTo(logo.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-16)
        }
    }
    
}
