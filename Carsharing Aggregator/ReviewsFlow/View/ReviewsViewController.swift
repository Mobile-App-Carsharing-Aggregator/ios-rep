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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(ReviewsCell.self, forCellReuseIdentifier: ReviewsCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
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
        bind()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getReviewsFromNetwork()
        reloadPlaceholder()
    }
    
    // MARK: - Actions
    @objc private func didTapBackFromReviews() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc private func didTapCloseReviews() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    // MARK: - Methods
    private func reloadPlaceholder() {
        if viewModel.reviews.count == 0 {
            placeholderLabel.isHidden = false
            tableView.isHidden = true
        } else {
            placeholderLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
    private func bind() {
        viewModel.$reviews.bind { [weak self] _ in
            self?.tableView.reloadData()
            self?.reloadPlaceholder()
        }
        
        viewModel.$isLoading.bind { isLoading in
            isLoading == true ? UIProgressHUD.show() : UIProgressHUD.dismiss()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [placeholderLabel, titleLabel, closeReviewsButton, backFromReviewsButton, tableView].forEach {
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
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(74)
        }
    }
}

// MARK: - UITableViewDataSource
extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewsCell.reuseIdentifier, for: indexPath) as? ReviewsCell else { return UITableViewCell()}
        
        let review = viewModel.reviews[indexPath.row]
        cell.configureCell(with: review)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ReviewsViewController: UITableViewDelegate {}
