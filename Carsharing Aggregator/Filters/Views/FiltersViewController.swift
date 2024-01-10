//
//  FiltersViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import UIKit
import SnapKit

protocol FiltersViewControllerDelegate: AnyObject {
    func updateSelectedFilters(selectedFilters: [ListSection: [ListItem]])
}

class FiltersViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FiltersViewModel
    private let sections = MockData.shared.pageData
    public var delegate: FiltersViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var titleVC: UILabel = {
        let label = UILabel()
        label.text = "Фильтр"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var buttonBackward: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self,
                         action: #selector(closeFilters),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonClearFilters: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.carsharing.blue, for: .normal)
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self,
                         action: #selector(clearFilters),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = .carsharing.white
        return background
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifare)
        collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: RatingCollectionViewCell.identifare)
        collectionView.register(FiltersSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: FiltersSupplementaryView.identifier)
        collectionView.collectionViewLayout = createLayout()
        return collectionView
    }()
    
    private lazy var numberOfCarsButton: UIButton = {
        let bookButton = UIButton()
        bookButton.backgroundColor = UIColor.carsharing.black
        bookButton.setTitle("НАЙТИ", for: .normal)
        bookButton.setTitleColor(UIColor.carsharing.white, for: .normal)
        bookButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        bookButton.layer.cornerRadius = 26
        bookButton.addTarget(self, action: #selector(numberOfCarsButtonTapped), for: .touchUpInside)
        return bookButton
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: FiltersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setupLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.onRefreshAction = { [weak self] indexPath, shouldUpdateCarsSection in
            self?.collectionView.reloadItems(at: [indexPath])
            if shouldUpdateCarsSection {
                self?.collectionView.reloadSections(IndexSet(integer: 1))
            }
        }
    }
    
    @objc private func closeFilters() {
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc private func numberOfCarsButtonTapped() {
        delegate?.updateSelectedFilters(selectedFilters: viewModel.selectedFilters)
        viewModel.coordinator?.coordinatorDidFinish()
    }
    
    @objc private func clearFilters() {
        delegate?.updateSelectedFilters(selectedFilters: [:])
        viewModel.selectedFilters = [:]
        collectionView.reloadData()
    }
}

// MARK: - Create Layout
extension FiltersViewController {
    private func addSubviews() {
        view.addSubview(titleVC)
        view.addSubview(buttonClearFilters)
        view.addSubview(buttonBackward)
        view.addSubview(collectionView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(numberOfCarsButton)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleVC.snp.bottom).offset(22)
            make.bottom.equalTo(backgroundView.snp.top)
        }
        
        titleVC.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.width.equalTo(63)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(148)
        }
        
        buttonClearFilters.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(78)
            make.trailing.equalToSuperview().inset(21)
        }
        
        buttonBackward.snp.makeConstraints { make in
            make.centerY.equalTo(titleVC.snp.centerY)
            make.height.width.equalTo(40)
            make.leading.equalToSuperview().offset(10)
        }
        
        numberOfCarsButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(68)
            make.leading.trailing.equalToSuperview().inset(21)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 0, leading: 21, bottom: 0, trailing: 21)
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            return section
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .estimated(30)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
}

// MARK: Extension UICollectionViewDataSource

extension FiltersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        let isSelected = viewModel.filters(for: section).contains(item)
        let isSelectedBigCompany = viewModel.isSelectedBigCompany
        let isEnabled = !(isSelectedBigCompany && MockData.shared.typeOfSmallCars.contains(item.id))
        switch sections[indexPath.section] {
        case .carsharing, .typeOfCar, .powerReserve, .different:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCollectionViewCell.identifare,
                for: indexPath) as? FilterCollectionViewCell
            else {
                return UICollectionViewCell()
            }

            cell.configure(
                title: item.title,
                isEnabled: isEnabled,
                isSelected: isSelected)
           
            return cell
            
        case .rating:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RatingCollectionViewCell.identifare,
                for: indexPath) as? RatingCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(
                title: item.title,
                image: item.image ?? UIImage(),
                borderColor: isSelected ? UIColor.carsharing.green : UIColor.carsharing.black,
                background: isSelected ? UIColor.carsharing.green : UIColor.carsharing.white90)
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FiltersSupplementaryView.identifier,
                for: indexPath) as! FiltersSupplementaryView
            header.configureHeader(filterName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: Extension UICollectionViewDelegate

extension FiltersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        let section = viewModel.sections[indexPath.section]
        viewModel.change(item, in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
}
