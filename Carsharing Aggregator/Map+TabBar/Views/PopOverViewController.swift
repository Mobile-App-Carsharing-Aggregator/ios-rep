//
//  PopOverViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 29.11.2023.
//

import UIKit
import SnapKit

class PopOverViewController: UIViewController {
    
    private let popoverLabel = {
        let label = UILabel()
        label.text = "Внесите данные банковской\n карты перед поездкой"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(popoverLabel)
    }
    
    private func setupLayout() {
        popoverLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().offset(16)
        }
    }
}
