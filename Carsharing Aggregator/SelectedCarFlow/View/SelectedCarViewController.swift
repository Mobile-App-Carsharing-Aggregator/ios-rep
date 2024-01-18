//
//  SelectedCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class SelectedCarViewController: UIViewController {
    
    // MARK: - Layout properties
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = viewModel.selectedCar.brand + " " + viewModel.selectedCar.model
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        return nameLabel
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem()
        closeButton.image = UIImage(systemName: "xmark")?.withTintColor(.carsharing.greyDark)
        closeButton.style = .plain
        closeButton.target = self
        closeButton.action = #selector(didTapCloseButton)
        return closeButton
    }()
    
    private lazy var carImage: UIImageView = {
        let carImage = UIImageView()
        guard let url = URL(string: viewModel.selectedCar.image ?? "") else { return UIImageView() }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .days(1)
        carImage.kf.indicatorType = .activity
        carImage.kf.setImage(with: url,
                             placeholder: nil,
                             options: [.cacheSerializer(FormatIndicatedCacheSerializer.png)])
        return carImage
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.register(SelectedCarCell.self, forCellWithReuseIdentifier: SelectedCarCell.reuseIdentifier)
        collectionView.register(SelectedCarRatingCell.self, forCellWithReuseIdentifier: SelectedCarRatingCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = createLayout()
        return collectionView
    }()
    
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = viewModel.selectedCar.company.bigIcon
        return logoImage
    }()
    
    private lazy var locationImage: UIImageView = {
        let locationImage = UIImageView()
        locationImage.image = .locationMark2
        return locationImage
    }()
    
    private lazy var timeImage: UIImageView = {
        let timeImage = UIImageView()
        timeImage.image = .walking
        return timeImage
    }()
    
    private lazy var carsheringStackView: UIStackView = {
        let carsheringStackView = UIStackView()
        carsheringStackView.axis = .vertical
        carsheringStackView.alignment = .fill
        carsheringStackView.spacing = 0
        carsheringStackView.distribution = .fillEqually
        return carsheringStackView
    }()
    
    private lazy var carsheringNameLabel: UILabel = {
        let carsheringNameLabel = UILabel()
        carsheringNameLabel.text = viewModel.selectedCar.company.name
        carsheringNameLabel.font = .systemFont(ofSize: 16)
        carsheringNameLabel.textColor = .carsharing.black
        return carsheringNameLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "от \(viewModel.selectedCar.company.price) ₽/мин"
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .carsharing.greyDark
        return priceLabel
    }()
    
    private lazy var addressStackView: UIStackView = {
        let addressStackView = UIStackView()
        addressStackView.axis = .vertical
        addressStackView.alignment = .top
        addressStackView.spacing = 0
        addressStackView.distribution = .fill
        return addressStackView
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.minimumScaleFactor = 0.5
        addressLabel.textColor = .carsharing.black
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = .systemFont(ofSize: 14)
        cityLabel.textColor = .carsharing.greyDark
        return cityLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 16)
        timeLabel.textColor = .carsharing.black
        return timeLabel
    }()
    
    private lazy var bookButton: UIButton = {
        let bookButton = UIButton()
        bookButton.backgroundColor = .carsharing.black
        bookButton.setTitle("ЗАБРОНИРОВАТЬ", for: .normal)
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        bookButton.layer.cornerRadius = 26
        bookButton.addTarget(self, action: #selector(bookButtonDidTap), for: .touchUpInside)
        return bookButton
    }()
    
    // MARK: - Properties
    var viewModel: SelectedCarViewModel
    
    // MARK: - LifeCycle
    init(viewModel: SelectedCarViewModel) {
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
    
    // MARK: - Actions
    @objc
    private func didTapCloseButton() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc
    private func bookButtonDidTap() {
        let defaults = UserDefaults.standard
        let car = viewModel.selectedCar
        let carDictionary = ["id": car.id,
                             "model": car.model] as [String : Any]
        defaults.setValue(carDictionary, forKey: "car")
    }
    
    // MARK: - Methods
    private func bind() {
        viewModel.$city.bind() { [weak self] city in
            self?.addressStackView.addArrangedSubview(self?.cityLabel ?? UILabel())
            self?.cityLabel.text = city
        }
        
        viewModel.$street.bind() { [weak self] street in
            self?.addressStackView.addArrangedSubview(self?.addressLabel ?? UILabel())
            self?.addressStackView.addArrangedSubview(self?.cityLabel ?? UILabel())
            self?.addressLabel.text = street
        }
        
        viewModel.$time.bind() { [weak self] _ in
            guard let self = self else { return }
            self.timeLabel.text = "~\(self.viewModel.time)"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeButton
        navigationController?.navigationBar.tintColor = .carsharing.black
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = false
        
        [nameLabel, carImage, collectionView, logoImage, locationImage, timeImage, carsheringStackView, addressStackView, timeLabel, bookButton].forEach {
            view.addSubview($0)
        }
        
        [carsheringNameLabel, priceLabel].forEach {
            carsheringStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
            make.height.equalTo(22)
        }
        
        carImage.snp.makeConstraints { make in
            make.top.equalTo(view).offset(58)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 200, height: 120))
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalTo(carImage.snp.bottom).offset(12)
            make.height.equalTo(24)
        }
        
        logoImage.snp.makeConstraints { make in
            make.leading.equalTo(collectionView.snp.leading)
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        locationImage.snp.makeConstraints { make in
            make.centerX.equalTo(logoImage.snp.centerX)
            make.top.equalTo(logoImage.snp.bottom).offset(28)
        }
        
        timeImage.snp.makeConstraints { make in
            make.centerX.equalTo(logoImage.snp.centerX)
            make.top.equalTo(locationImage.snp.bottom).offset(28)
        }
        
        carsheringStackView.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(12)
            make.centerY.equalTo(logoImage.snp.centerY)
            make.height.equalTo(40)
        }
        
        addressStackView.snp.makeConstraints { make in
            make.leading.equalTo(carsheringStackView.snp.leading)
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalTo(locationImage.snp.centerY)
            make.height.equalTo(40)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(carsheringStackView.snp.leading)
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalTo(timeImage.snp.centerY)
            // make.height.equalTo(21)
        }
        
        bookButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(52)
            make.top.equalTo(timeLabel.snp.bottom).offset(28)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(24))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(8)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SelectedCarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let selectedCarCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SelectedCarCell.reuseIdentifier,
                for: indexPath) as? SelectedCarCell else { return UICollectionViewCell() }
            selectedCarCell.configure(title: viewModel.selectedCar.typeCar.name)
            return selectedCarCell
        } else if indexPath.row == 1 {
            guard let selectedCarCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SelectedCarCell.reuseIdentifier,
                for: indexPath) as? SelectedCarCell else { return UICollectionViewCell() }
            selectedCarCell.configure(title: "Полный бак")
            return selectedCarCell
        } else if indexPath.row == 2 {
            guard let selectedCarRatingCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SelectedCarRatingCell.reuseIdentifier,
                for: indexPath) as? SelectedCarRatingCell else { return UICollectionViewCell() }
            selectedCarRatingCell.configure(title: "\(Int(viewModel.selectedCar.rating))")
            return selectedCarRatingCell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension SelectedCarViewController: UICollectionViewDelegate {}
