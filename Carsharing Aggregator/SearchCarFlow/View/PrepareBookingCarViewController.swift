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
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.backward")?.withTintColor(.carsharing.greyDark),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var closeButton = UIBarButtonItem(
        image: UIImage(systemName: "xmark")?.withTintColor(.carsharing.greyDark),
        style: .plain,
        target: self,
        action: #selector(didTapCloseButton)
    )
    
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
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
        navigationController?.navigationBar.tintColor = .carsharing.black
        navigationController?.navigationBar.backgroundColor = .clear
        guard let car = car else { return }
        title = car.name + " " + car.model
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [carImage, vStack, carTypeLabel, carRatingLabel].forEach {
            view.addSubview($0)
        }
        
        configureCarInfo()
        configureStack()
        setupNavBar()
        setupConstraints()
    }
    
    private func setupConstraints() {
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

