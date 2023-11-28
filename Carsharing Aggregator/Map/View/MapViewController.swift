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
    private enum Const {
        static let point = YMKPoint(latitude: 55.751280, longitude: 37.629720)
        static let cameraPosition = YMKCameraPosition(target: point, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
    }
    
    private var carsLocation = [
        YMKPoint(latitude: 55.751280, longitude: 37.629724),
        YMKPoint(latitude: 54.751389, longitude: 36.629410),
        YMKPoint(latitude: 55.751266, longitude: 38.629710),
        YMKPoint(latitude: 56.751293, longitude: 35.629728),
        YMKPoint(latitude: 54.751281, longitude: 36.629726)]
    
    private var mapView: YMKMapView = YBaseMapView().mapView
    private lazy var map: YMKMap = mapView.mapWindow.map
    private var pinsCollection: YMKMapObjectCollection?
    private lazy var mapObjectTapListener: YMKMapObjectTapListener = MapObjectTapListener(controller: self)
    
    private lazy var tabView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        tabView.delegate = self
        map = mapView.mapWindow.map
        map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: 55.751280, longitude: 37.629724),
                zoom: 5,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
        addCars()
    }
    
    private func addPlacemark(_ map: YMKMap, geometry: YMKPoint) {
        let image = UIImage.pointBlack
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = geometry
        placemark.setIconWith(image)
        placemark.addTapListener(with: mapObjectTapListener)
    }
    
    private func addCars() {
        for i in carsLocation {
            addPlacemark(map, geometry: i)
        }
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
