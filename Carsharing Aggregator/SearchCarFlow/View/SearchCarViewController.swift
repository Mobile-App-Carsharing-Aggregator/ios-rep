//
//  SearchCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 10.12.2023.
//

import UIKit

final class SearchCarViewController: UIViewController {
    
    // MARK: - UI
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
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Легковые", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 2
        view.addTarget(self, action: #selector(didTapTruckCarFilterButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var truckCarFilterButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Грузовые", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 2
        view.addTarget(self, action: #selector(didTapTruckCarFilterButton), for: .touchUpInside)
        return view
    }()
    
    
    // MARK: - Properties
    weak var coordinator: Coordinator?
    var viewModel: SearchCarViewModelProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        carsCollection.dataSource = self
        carsCollection.delegate = self
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        [carsCollection, passengerCarFilterButton, truckCarFilterButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - Actions
    @objc
    private func didTapPassengerCarFilterButton() {
        
    }
    
    @objc
    private func didTapTruckCarFilterButton() {
        
    }
}

    // MARK: - UICollectionViewDataSource
extension SearchCarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.listOfCars.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

    // MARK: - UICollectionViewDelegateFlowLayout
extension SearchCarViewController: UICollectionViewDelegateFlowLayout {
    
}
