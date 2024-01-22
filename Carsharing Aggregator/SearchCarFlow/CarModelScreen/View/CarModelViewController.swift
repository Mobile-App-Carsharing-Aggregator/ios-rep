//
//  PrepareBookingCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 12.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CarModelViewController: UIViewController {
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
        button.tintColor = .carsharing.greyDark
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
    
    private lazy var carTypeView: CarTypeView = {
        let view = CarTypeView()
     
        return view
    }()
    
    // MARK: - Properties
    var viewModel: CarModelViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Methods
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$carModel.bind { [weak self] carModel in
            guard
                let carModel = carModel,
                let self
            else { return }
            self.configureStack(for: carModel)
            self.configureCarInfo(with: carModel)
            self.carTypeView.configure(title: carModel.typeCar.name)
        }
    }
    
    // MARK: - Layout Methods
    private func configureStack(for carModel: CarModel) {
        for company in carModel.companies {
            let view = TransitionToCarSharingButton()
            view.configure(with: company)
            vStack.addArrangedSubview(view)
        }
    }
    
    private func configureCarInfo(with carModel: CarModel) {
        guard
            let image = carModel.image,
            let urlImage = URL(string: image)
        else { return }
        carImage.kf.setImage(with: urlImage)
        titleVC.text = "\(carModel.brand) \(carModel.model)"
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [carImage, vStack, carTypeView, titleVC, backButton, closeButton].forEach {
            view.addSubview($0)
        }
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
        
        carTypeView.snp.makeConstraints { make in
            make.top.equalTo(carImage.snp.bottom).offset(12)
            make.height.equalTo(24)
            make.leading.equalTo(view).offset(21)
        }
        
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.top.equalTo(carTypeView.snp.bottom).offset(20)
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapCloseButton() {
        viewModel?.didTapCloseButton()
    }
}
//
//// MARK: - TransitionToCarSharingButtonDelegate
//
//extension CarModelViewController: TransitionToCarSharingButtonDelegate {
//    func didTapLink(sender: sender, carsharingCompany: carsharingCompany) {
//        guard let company = carsharingCompany else { return }
//        let appStoreURL = URL(string: "https://apps.apple.com/app/id\(company.appStoreID)")!
//        if UIApplication.shared.canOpenURL(appStoreURL) {
//            UIApplication.shared.open(appStoreURL)
//        }
//    }
//}
