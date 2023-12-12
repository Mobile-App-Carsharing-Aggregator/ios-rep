//
//  FiltersViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 08.12.2023.
//

import UIKit
import SnapKit

class FiltersViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FiltersViewModel
    private let sections = MockData.shared.pageData
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifare)
        collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: RatingCollectionViewCell.identifare)
        collectionView.register(FiltersSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FiltersSupplementaryView.identifier)
        collectionView.collectionViewLayout = createLayout()
        return collectionView
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
        
        collectionView.reloadData()
    }
}

// MARK: - Create Layout
extension FiltersViewController {
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
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
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .carsharing(let carsharing):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCollectionViewCell.identifare,
                for: indexPath) as? FilterCollectionViewCell
            else {
                    return UICollectionViewCell()
                }
            cell.configure(
                title: carsharing[indexPath.row].title,
                textColor: UIColor.black,
                borderColor: UIColor.black)
            return cell
            
        case .typeOfCar(let typeOfCar):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCollectionViewCell.identifare,
                for: indexPath) as? FilterCollectionViewCell
            else {
                    return UICollectionViewCell()
                }
            cell.configure(
                title: typeOfCar[indexPath.row].title,
                textColor: UIColor.black,
                borderColor: UIColor.black)
            return cell
            
        case .powerReserve(let powerReserve):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCollectionViewCell.identifare,
                for: indexPath) as? FilterCollectionViewCell
            else {
                    return UICollectionViewCell()
                }
            cell.configure(
                title: powerReserve[indexPath.row].title,
                textColor: UIColor.black,
                borderColor: UIColor.black)
            return cell
            
        case .rating(let powerReserve):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RatingCollectionViewCell.identifare,
                for: indexPath) as? RatingCollectionViewCell
            else {
                    return UICollectionViewCell()
                }
            cell.configure(title: powerReserve[indexPath.row].title, image: powerReserve[indexPath.row].image)
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

extension FiltersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
