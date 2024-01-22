//
//  ReviewsCell.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 20.01.2024.
//

import Foundation
import UIKit

final class ReviewsCell: UITableViewCell {
    
    // MARK: - Layout properties
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .carsharing.greyDark
        return dateLabel
    }()
    
    private lazy var dotsButton: UIButton = {
        let dotsButton = UIButton()
        dotsButton.setImage(UIImage.dots, for: .normal)
        return dotsButton
    }()
    
    private var carLabel: UILabel = {
        let carLabel = UILabel()
        carLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        carLabel.textColor = .carsharing.black
        return carLabel
    }()
    
    private var carsharingCompanyLabel: UILabel = {
        let carsharingCompanyLabel = UILabel()
        carsharingCompanyLabel.font = .systemFont(ofSize: 14, weight: .regular)
        carsharingCompanyLabel.textColor = .carsharing.greyDark
        return carsharingCompanyLabel
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.backgroundColor = .clear
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.numberOfLines = 0
        commentLabel.font = .systemFont(ofSize: 16, weight: .light)
        commentLabel.textColor = .carsharing.black
        return commentLabel
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with review: ReviewsCellModel) {
        dateLabel.text = review.date
        carLabel.text = review.carModel
        carsharingCompanyLabel.text = review.company.name
        updateRating(with: review.rating)
        commentLabel.text = review.comment
    }
    
    private func updateRating(with rating: Int) {
        let stars = ratingStackView.arrangedSubviews
        for i in 0...4 {
            guard let star = stars[i] as? UIImageView else { return }
            let image = star.tag > rating ? UIImage.starMenu : UIImage.smallGreenRating
            star.image = image
        }
    }
    
    private func setupUI() {
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = .clear
        self.selectedBackgroundView = backgroundColorView
        
        [dateLabel, dotsButton, carLabel, carsharingCompanyLabel, ratingStackView, commentLabel].forEach {
            contentView.addSubview($0)
        }
        
        for i in 1...5 {
            let star = UIImageView()
            star.image = UIImage.smallGreenRating
            star.tag = i
            ratingStackView.addArrangedSubview(star)
        }
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(21)
            make.top.equalTo(contentView).offset(3)
        }
        
        dotsButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(contentView.snp.trailing).inset(21)
            make.size.equalTo(24)
        }
        
        carLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(21)
        }
        
        carsharingCompanyLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(carLabel.snp.bottom).offset(4)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(carsharingCompanyLabel.snp.bottom).offset(12)
            make.width.equalTo(136)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.trailing.equalTo(contentView.snp.trailing).inset(53)
            make.top.equalTo(ratingStackView.snp.bottom).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).inset(30)
        }
    }
}
