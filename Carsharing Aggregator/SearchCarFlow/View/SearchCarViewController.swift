//
//  SearchCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

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
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .carsharing.greyDark
        button.addTarget(self,
                         action: #selector(didTapBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var resetFiltersButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Сбросить", for: .normal)
        button.tintColor = .carsharing.blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(didTapResetFiltersButton), for: .touchUpInside)
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
    
    private lazy var passengerCarFilterButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .white
        view.setTitle("Легковые", for: .normal)
        view.tintColor = .carsharing.black
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.addTarget(self, action: #selector(didTapTruckCarFilterButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var truckCarFilterButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .white
        view.setTitle("Грузовые", for: .normal)
        view.tintColor = .black
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.addTarget(self, action: #selector(didTapTruckCarFilterButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        view.tintColor = .carsharing.blue
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
        viewModel?.startObserve()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.isMovingFromParent {
            viewModel?.cleanUp()
        }
    }
    
    // MARK: - Methods
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$listOfCars.bind { [weak self] _ in
            self?.carsCollection.reloadData()
        }
    }
    
    func didSelect(car: Car) {
        let vc = PrepareBookingCarViewController()
        vc.car = car
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        present(vc, animated: true)
    }
    
    // MARK: - Layout Methods
    private func setupUI() {
        view.backgroundColor = .white
        [backButton, titleVC, resetFiltersButton, carsCollection, passengerCarFilterButton, truckCarFilterButton, searchButton].forEach {
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
        
        resetFiltersButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.equalTo(24)
            make.trailing.equalTo(view).offset(-30)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.width.equalTo(24)
            make.leading.equalTo(view).offset(30)
        }
        
        passengerCarFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(21)
            make.top.equalTo(backButton.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 104, height: 40))
        }
        
        truckCarFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(passengerCarFilterButton.snp.trailing).offset(12)
            make.centerY.equalTo(passengerCarFilterButton.snp.centerY)
            make.size.equalTo(CGSize(width: 104, height: 40))
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-21)
            make.width.height.equalTo(24)
            make.centerY.equalTo(passengerCarFilterButton.snp.centerY)
        }
        
        carsCollection.snp.makeConstraints { make in
            make.top.equalTo(passengerCarFilterButton.snp.bottom).offset(24)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapPassengerCarFilterButton() {
        
    }
    
    @objc
    private func didTapTruckCarFilterButton() {
        
    }
    
    @objc
    private func didTapSearchButton() {
        
    }
    
    @objc
    private func didTapResetFiltersButton() {
        
    }
    
    @objc
    private func didTapBackButton() {
        viewModel?.cleanUp()
//    TODO: - Need change
        navigationController?.popViewController(animated: true)
    }
}

    // MARK: - UICollectionViewDataSource
extension SearchCarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.listOfCars.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarCell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.reuseIdentifier, for: indexPath) as! CarCell
        guard let model = viewModel?.listOfCars[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(with: model)
        
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension SearchCarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CarCell = collectionView.cellForItem(at: indexPath) as! CarCell
        guard let car = cell.carModel else { return }
        // TODO: - do it via coordinator
        didSelect(car: car)
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
