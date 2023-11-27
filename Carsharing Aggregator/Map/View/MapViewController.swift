//
//  MapViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 27.11.2023.
//

import UIKit
import YandexMapsMobile
import SnapKit

final class MapViewController: UIViewController {
    
    private lazy var mapView: YMKMapView = YBaseMapView().mapView
    private lazy var tabView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        tabView.delegate = self
        addPlacemarkOnMap()
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(tabView)
    }
    
    private func setupLayout() {
        mapView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tabView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.equalTo(mapView.snp.leading).offset(24)
            make.trailing.equalTo(mapView.snp.trailing).offset(-24)
            make.bottom.equalTo(mapView.snp.bottom).offset(-50)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabView.layer.masksToBounds = true
        tabView.layer.shadowRadius = 5
        tabView.layer.shadowColor = UIColor.black.cgColor
        tabView.layer.shadowPath = UIBezierPath(rect: tabView.bounds).cgPath
        tabView.layer.shadowOffset = CGSize.zero
        tabView.layer.shadowOpacity = 1
    }
    
    private func addPlacemarkOnMap() {
        // Задание координат точки
        let point = YMKPoint(latitude: 47.228836, longitude: 39.715875)
        let viewPlacemark: YMKPlacemarkMapObject = mapView.mapWindow.map.mapObjects.addPlacemark()
        viewPlacemark.geometry = point
        
        // Настройка и добавление иконки
        viewPlacemark.setIconWith(
            UIImage.pointBlack, // Убедитесь, что у вас есть иконка для точки
            style: YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil
            )
        )
    }
}

extension MapViewController: TabViewDelegate {
    func profileButtonTapped() {
    
    }
    
    func filtersButtonTapped() {
        
    }
    
    func carSearchButtonTapped() {
        
    }
    
    func orderButtonTapped() {
        
    }
    
    func locationButtonTapped() {
        
    }
}
