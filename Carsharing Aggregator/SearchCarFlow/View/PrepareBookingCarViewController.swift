//
//  PrepareBookingCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 12.12.2023.
//

import UIKit
import SnapKit

final class PrepareBookingCarViewController: UIViewController {
    // MARK: - UI
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .carsharing.black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .carsharing.greyDark
        button.addTarget(self,
                         action: #selector(didTapBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self,
                         action: #selector(didTapCloseButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var carImage: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var carTypeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .carsharing.greyLight
        label.textColor = .carsharing.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    private lazy var carRatingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .carsharing.greyLight
        label.textColor = .carsharing.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        return label
    }()
    
    // MARK: - Properties
    var car: Car?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    // MARK: - Layout Methods
    private func configureStack() {
        let yandex = TransitionToCarSharingButton()
        yandex.configure(with: "ЯндексДрайв", companyLogo: .drive!)
        let deli = TransitionToCarSharingButton()
        deli.configure(with: "ДелиМобиль", companyLogo: .deli!)
        let city = TransitionToCarSharingButton()
        city.configure(with: "СитиМобил", companyLogo: .city!)
        
        vStack.addArrangedSubview(yandex)
        vStack.addArrangedSubview(deli)
        vStack.addArrangedSubview(city)
    }
    
    private func configureCarInfo() {
        carImage.image = UIImage(systemName: "car.side.lock.open.fill")
        guard let car = car else { return }
        titleVC.text = car.brand + " " + car.model
        carRatingLabel.text = String(car.rating) + " " + "stars"
        carTypeLabel.text = {
            switch car.type {
            case .coupe: return "Купе"
            case .hatchback: return "Хэтчбек"
            case .minivan: return "Минивен"
            case .sedan: return "Седан"
            case .universal: return "Универсал"
            case .other: return "Другое"
            }
        }()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [carImage, vStack, carTypeLabel, carRatingLabel, titleVC, backButton, closeButton].forEach {
            view.addSubview($0)
        }
        configureCarInfo()
        configureStack()
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleVC.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view).offset(26)
            make.height.equalTo(22)
            make.width.lessThanOrEqualTo(290)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.width.equalTo(24)
            make.trailing.equalTo(view).offset(-30)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.width.equalTo(24)
            make.leading.equalTo(view).offset(30)
        }
        
        carImage.snp.makeConstraints { make in
            make.top.equalTo(view).offset(58)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 200, height: 125))
        }
        
        carTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(carImage.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(21)
            make.size.equalTo(CGSize(width: 74, height: 24))
        }
        
        carRatingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(carTypeLabel.snp.centerY)
            make.leading.equalTo(carTypeLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: 74, height: 24))
        }
        
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.top.equalTo(carTypeLabel.snp.bottom).offset(40)
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapCloseButton() {
        
    }
}
