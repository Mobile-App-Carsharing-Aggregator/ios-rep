//
//  ReviewsViewController.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 19.01.2024.
//

import UIKit
import SnapKit

final class ReviewsViewController: UIViewController {
    
    // MARK: - Layout properties
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Пока нет отзывов"
        placeholderLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return placeholderLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Отзывы"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .carsharing.black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var backFromReviewsButton: UIButton = {
        let backFromReviewsButton = UIButton()
        backFromReviewsButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backFromReviewsButton.tintColor = .carsharing.greyDark
        backFromReviewsButton.addTarget(self,
                                        action: #selector(didTapBackFromReviews),
                                        for: .touchUpInside)
        return backFromReviewsButton
    }()
    
    private lazy var closeReviewsButton: UIButton = {
        let closeReviewsButton = UIButton()
        closeReviewsButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeReviewsButton.tintColor = .carsharing.greyDark
        closeReviewsButton.addTarget(self,
                                     action: #selector(didTapCloseReviews),
                                     for: .touchUpInside)
        return closeReviewsButton
    }()
    
    // MARK: - Properties
    var viewModel: ReviewsViewModel
    
    // MARK: - LifeCycle
    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Actions
    @objc private func didTapBackFromReviews() {
        print("BACK")
//        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc private func didTapCloseReviews() {
        print("CLOSE")
//        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = false
        
        [placeholderLabel, titleLabel, closeReviewsButton, backFromReviewsButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
            make.height.equalTo(22)
        }
        
        closeReviewsButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-21)
        }
        
        backFromReviewsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.width.equalTo(24)
            make.leading.equalToSuperview().offset(30)
        }
    }
}
