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
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jon Snow"
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        return label
    }()
    
    private lazy var profileItemButton: UIButton = {
        let button = UIButton.systemButton(
            with: .forward!,
            target: self,
            action: #selector(didTapProfileItemButton)
        )
        button.tintColor = .black
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - Properties
    weak var coordinator: Coordinator?
    var viewModel: ProfileViewModelProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        [profileNameLabel, profileItemButton, tableView].forEach {
            view.addSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        profileItemButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.trailing.equalTo(view).offset(-12)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(profileNameLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapProfileItemButton() {
        
    }
}

    // MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 6
        case 2: return 3
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        cell.detailTextLabel?.textColor = .gray
        
        var cellText = ""
        var detailText = ""
        var accessoryType: UITableViewCell.AccessoryType = .none
        
        switch indexPath.section {
        case 0:
            cellText = "Бонусные баллы"
            /* TO DO: - add bonuses presentation via viewModel
             cell.accessoryView =
             */
            
        case 1:
            switch indexPath.row {
            case 0:
                cellText = "Уведомления"
                accessoryType = .disclosureIndicator
            case 1:
                cellText = "Карты для оплаты"
                accessoryType = .disclosureIndicator
            case 2:
                cellText = "Заказы"
                detailText = "Текущие, прошедшие, запланированные"
                accessoryType = .disclosureIndicator
            case 3:
                cellText = "Адреса"
                detailText = "Дом, работа и остальные"
                accessoryType = .disclosureIndicator
            case 4:
                cellText = "Отзывы"
            case 5:
                cellText = "Страховка"
                
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                cellText = "Правила использования"
            case 1:
                cellText = "Техподдержка"
            case 2:
                cellText = "Настройки"
            default:
                break
            }
        default:
            break
        }
        
        cell.textLabel?.text = cellText
        cell.detailTextLabel?.text = detailText
        cell.accessoryType = accessoryType
        return cell
    }
    
}

    // MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = viewModel else { return nil }
        guard section > (model.numberOfSections.count - 1) else { return nil }
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray
        return separatorView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let model = viewModel else { return 0 }
        guard section > (model.numberOfSections.count - 1) else { return 0 }
        
        return 1.0
    }
}
