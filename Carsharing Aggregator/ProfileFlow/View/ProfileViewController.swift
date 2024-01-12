//
//  ProfileViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 28.11.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    // MARK: - UI
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .carsharing.black
        label.textAlignment = .center
        label.text = "Профиль"
        return label
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
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .carsharing.grey
        return image
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.register(
                    ProfileMenuCell.self,
                    forCellReuseIdentifier: ProfileMenuCell.reuseIdentifier
                )
        return table
    }()
    
    // MARK: - Properties
    weak var coordinator: Coordinator?
    var viewModel: ProfileViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Methods
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$fullName.bind { [weak self] _ in
            self?.profileNameLabel.text = "\(viewModel.fullName)"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [titleVC, closeButton, avatarImage, profileNameLabel, tableView].forEach {
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
        
        avatarImage.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.leading.equalTo(view).offset(21)
            make.top.equalTo(titleVC.snp.bottom).offset(22)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage.snp.trailing).offset(12)
            make.centerY.equalTo(avatarImage.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(21)
            make.trailing.equalTo(view.snp.trailing).offset(-21)
            make.top.equalTo(avatarImage.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
}

    // MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch section {
        case 0:
            return viewModel.numberOfSections[0]
        case 1:
            return viewModel.numberOfSections[1]
        case 2:
            return viewModel.numberOfSections[2]
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileMenuCell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuCell.reuseIdentifier) as! ProfileMenuCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: 
                cell.configureCell(with: .MyMarks)
            case 1: 
                cell.configureCell(with: .SearchHistory)
            default: 
                break
            }
        case 1:
            cell.configureCell(with: .Settings)
        case 2:
            switch indexPath.row {
            case 0:
                cell.configureCell(with: .Logout)
            case 1:
                cell.configureCell(with: .DeleteAccount)
            default:
                break
            }
        default:
            break
        }
        return cell
    }
}

    // MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}
