//
//  ReviewAndRatingViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 16.01.2024.
//

import UIKit
import SnapKit

protocol ReviewAndRatingViewControllerDelegate {
    func commentViewOpened()
}

class ReviewAndRatingViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ReviewAndRatingViewModel
    private var currentRating = 0
    private let maxRating = 5
    private var comment: String = ""
   
    var delegate: ReviewAndRatingViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.text = "Как вам " + viewModel.modelCar + "?"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .carsharing.black
        return label
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.darkGray
        button.addTarget(self,
                         action: #selector(closeReviewAndRating),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var buttonComment: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Оставить комментарий", for: .normal)
        button.setTitleColor(UIColor.carsharing.blue, for: .normal)
        button.titleLabel?.font = . systemFont(ofSize: 14)
        button.addTarget(self,
                         action: #selector(buttonCommentTapped),
                         for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    
    private lazy var labelForTextView: UILabel = {
        let label = UILabel()
        label.text = "Комментарий"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .carsharing.blue
        label.backgroundColor = .carsharing.white
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var textViewComment: UITextView = {
        let text = UITextView()
        text.roundCorners(.allCorners, radius: 12)
        text.isEditable = true
        text.backgroundColor = .carsharing.white
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor(named: "darkGrey")?.cgColor ?? UIColor.gray.cgColor
        text.text = ""
        text.textColor = .carsharing.greyDark
        text.font = .systemFont(ofSize: 16)
        text.textAlignment = .left
        text.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return text
    }()
    
    private lazy var buttonSave: UIButton = {
        let button = UIButton()
        button.backgroundColor = .carsharing.black
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.setTitleColor(UIColor.carsharing.white, for: .normal)
        button.titleLabel?.font = . systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 26
        button.addTarget(self,
                         action: #selector(buttonSaveTapped),
                         for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    init(viewModel: ReviewAndRatingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .carsharing.white
        textViewComment.delegate = self
        addSubviews()
        setupLayout()
    }
    
    @objc private func closeReviewAndRating() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc private func starTapped(sender: UIButton) {
        updateRatingView(with: sender.tag)
        currentRating = sender.tag + 1
        buttonSave.isUserInteractionEnabled = true
    }
    
    private func updateRatingView(with tag: Int) {
        let buttons = ratingStackView.arrangedSubviews
        for i in 0..<maxRating {
            if i <= buttons.count - 1,
               let button = buttons[i] as? UIButton {
                let image = tag >= i ? UIImage(named: "bigStarGreen") : UIImage(named: "bigStarWhite")
                button.setImage(image, for: .normal)
            }
        }
    }
    
    @objc private func buttonCommentTapped() {
        buttonComment.isHidden = true
        textViewComment.text = "Комментарий"
        delegate?.commentViewOpened()
        view.addSubview(textViewComment)
        view.addSubview(labelForTextView)
        
        textViewComment.snp.makeConstraints { make in
            make.height.equalTo(88)
            make.top.equalTo(ratingStackView.snp.bottom).offset(24)
            make.width.equalTo(widthScreen - 42)
            make.centerX.equalToSuperview()
        }
        labelForTextView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(94)
            make.top.equalTo(textViewComment.snp.top).offset(-8)
            make.leading.equalTo(textViewComment.snp.leading).offset(12)
        }
    }
    
    @objc private func buttonSaveTapped() {
        self.viewModel.saveReviewAndRating(
            rating: currentRating,
            comment: textViewComment.text)
        self.viewModel.coordinator?.coordinatorDidFinish()
        self.viewModel.coordinator?.showRatingAlert()
    }
}

// MARK: - Extension UITextViewDelegate
extension ReviewAndRatingViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        labelForTextView.isHidden = false
        if textView.textColor == .carsharing.greyDark {
            textView.text = ""
            textView.textColor = .carsharing.black
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            view.endEditing(true)
            labelForTextView.isHidden = true
            comment = textView.text
            return false
        } else {
            if textView.text.count + (text.count - range.length) <= 200 {
                return true
            } else {
                return false
            }
        }
    }
}

// MARK: - Create Layout
extension ReviewAndRatingViewController {
    private func addSubviews() {
        view.addSubview(titleVC)
        view.addSubview(buttonClose)
        view.addSubview(ratingStackView)
        for i in 0..<maxRating {
            let button = UIButton()
            button.setImage(UIImage(named: "bigStarWhite"), for: .normal)
            button.tag = i
            button.addTarget(self,
                             action: #selector(starTapped),
                             for: .touchUpInside)
            ratingStackView.addArrangedSubview(button)
        }
        view.addSubview(buttonComment)
        view.addSubview(buttonSave)
    }
    
    private func setupLayout() {
        titleVC.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(30)
            make.height.equalTo(22)
            make.width.equalTo(250)
        }
        buttonClose.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.equalTo(view.snp.top).offset(31)
            make.trailing.equalTo(view.snp.trailing).offset(-21)
        }
        ratingStackView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(270)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleVC.snp.bottom).offset(22)
        }
        buttonComment.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(165)
            make.top.equalTo(ratingStackView.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(21)
        }
        buttonSave.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(widthScreen - 42)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-68)
        }
    }
}
