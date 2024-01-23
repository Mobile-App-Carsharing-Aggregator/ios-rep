//
//  SearchCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit
import ProgressHUD

final class SearchCarViewController: UIViewController {
    // MARK: - UI
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.text = "Машины"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .carsharing.black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .carsharing.black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self,
                         action: #selector(didTapCloseButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var carsCollection: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        view.register(
            CarCell.self,
            forCellWithReuseIdentifier: CarCell.reuseIdentifier
        )
        view.backgroundColor = .clear
        view.allowsMultipleSelection = false
        return view
    }()
    
    // MARK: - Properties
    var viewModel: SearchCarViewModel?
    private let collectionParams = UICollectionView.CollectionParams(
        cellCount: 2,
        leftInset: 21,
        rightInset: 21,
        topInset: 12,
        bottomInset: 12,
        height: 112,
        cellSpacing: 12
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
        carsCollection.dataSource = self
        carsCollection.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Methods
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$isLoading.bind { [weak self] isLoading in
            if isLoading {
                UIProgressHUD.show()
            } else {
                UIProgressHUD.dismiss()
                self?.carsCollection.reloadData()
            }
        }
        
        viewModel.$carModels.bind { [weak self] _ in
            self?.carsCollection.reloadData()
        }
    }
    
    // MARK: - Layout Methods
    private func setupUI() {
        view.backgroundColor = .white
        [titleVC, closeButton, carsCollection].forEach {
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
            make.height.equalTo(24)
            make.trailing.equalTo(view).offset(-30)
        }
        
        carsCollection.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(21)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapCloseButton() {
        viewModel?.coordinator?.coordinatorDidFinish()
    }
}

    // MARK: - UICollectionViewDataSource
extension SearchCarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.carModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarCell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.reuseIdentifier, for: indexPath) as! CarCell
        guard let model = viewModel?.carModels[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(with: model)
        
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension SearchCarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CarCell = collectionView.cellForItem(at: indexPath) as! CarCell
        guard
            let carModel = cell.carModel,
            let viewModel = viewModel
        else { return }
        viewModel.didSelected(on: self, carModel: carModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableSpace = collectionView.frame.width - collectionParams.paddingWidth
        let cellWidth = availableSpace / collectionParams.cellCount
        return CGSize(width: cellWidth, height: collectionParams.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: collectionParams.topInset,
            left: collectionParams.leftInset,
            bottom: collectionParams.bottomInset,
            right: collectionParams.rightInset
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionParams.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionParams.cellSpacing
    }
}
