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
        table.allowsSelection = true
        table.register(
                    ProfileMenuCell.self,
                    forCellReuseIdentifier: ProfileMenuCell.reuseIdentifier
                )
        return table
    }()
    
    // MARK: - Properties
    var viewModel: ProfileViewModel
    
    // MARK: - Lifecycle
    init(viewModel: ProfileViewModel) {
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    // MARK: - Methods
    private func bind() {
        viewModel.$fullName.bind { [weak self] _ in
            self?.profileNameLabel.text = self?.viewModel.fullName
        }
        
        viewModel.$deleteUserSuccess.bind { [weak self] message in
            self?.showAlertAfterDeleteAccount(message: message)
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
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(avatarImage.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    private func showAlertForLogout() {
        
    // TODO: - перенести логику в ViewModel
        guard let token = TokenStorage.shared.getToken() else {
            showErrorAlert()
            return
        }
        guard let email = viewModel.user?.email else { return }
        let alert = UIAlertController(
            title: "Вы уверены, что хотите \n выйти из аккаунта \n \"\(email)\"?",
            message: "",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.viewModel.logout()
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlertForDeleteAccount() {
    // TODO: перенести логику в ViewModel
        guard let token = TokenStorage.shared.getToken() else {
            showErrorAlert()
            return
        }
        guard let email = viewModel.user?.email else { return }
        let alert = UIAlertController(
            title: "Вы уверены, что хотите \n удалить аккаунт \n \"\(email)\"?",
            message: "",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteAccount()
        })
        present(alert, animated: true)
    }
    
    private func showAlertAfterDeleteAccount(message: String) {
        let alert = UIAlertController(title: "Удаление аккаунта", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Для этой процедуры вы должны быть залогинены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
}

    // MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return viewModel.numberOfSections.count
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
        cell.selectionStyle = .none
        return cell
    }
}

    // MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 88
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                viewModel.openReviews(on: self)
            case 1:
                viewModel.openSearchHistory(on: self)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                viewModel.openSettings(on: self)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                showAlertForLogout()
            case 1:
                showAlertForDeleteAccount()
            default:
                break
            }
        default:
            break
        }
    }
}
