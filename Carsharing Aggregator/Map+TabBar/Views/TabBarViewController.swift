//
//  TabBarViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 27.11.2023.
//

import UIKit
import YandexMapsMobile
import SnapKit

final class TabBarViewController: UIViewController {
    weak var coordinator: TabBarCoordinator?
    
    private enum Const {
        static let point = YMKPoint(latitude: 54.751290, longitude: 35.629620)
        static let cameraPosition = YMKCameraPosition(target: point, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
    }
    
    private var carsLocation = [
        YMKPoint(latitude: 55.744389, longitude: 37.598402),
        YMKPoint(latitude: 55.739630, longitude: 37.594764),
        YMKPoint(latitude: 55.742048, longitude: 37.595123),
        YMKPoint(latitude: 55.744743, longitude: 37.586652),
        YMKPoint(latitude: 55.714843, longitude: 37.565741),
        YMKPoint(latitude: 55.714797, longitude: 37.565668),
        YMKPoint(latitude: 55.718651, longitude: 37.568095),
        YMKPoint(latitude: 55.724193, longitude: 37.557187),
        YMKPoint(latitude: 55.726254, longitude: 37.578652),
        YMKPoint(latitude: 55.733881, longitude: 37.538283),
        YMKPoint(latitude: 55.732776, longitude: 37.537228),
        YMKPoint(latitude: 55.843126, longitude: 37.486103),
        YMKPoint(latitude: 55.850115, longitude: 37.480832),
        YMKPoint(latitude: 55.840922, longitude: 37.461481),
        YMKPoint(latitude: 55.840329, longitude: 37.455382),
        YMKPoint(latitude: 55.857654, longitude: 37.487533),
        YMKPoint(latitude: 55.971617, longitude: 37.452978),
        YMKPoint(latitude: 55.970018, longitude: 37.445775),
        YMKPoint(latitude: 55.968566, longitude: 37.457891),
        YMKPoint(latitude: 55.978824, longitude: 37.387044),
        YMKPoint(latitude: 55.930342, longitude: 37.749893),
        YMKPoint(latitude: 55.922967, longitude: 37.753279),
        YMKPoint(latitude: 55.924097, longitude: 37.757589),
        YMKPoint(latitude: 55.922662, longitude: 37.766441),
        YMKPoint(latitude: 55.921749, longitude: 37.773823),
        YMKPoint(latitude: 55.921536, longitude: 37.765449),
        YMKPoint(latitude: 55.917371, longitude: 37.757016),
        YMKPoint(latitude: 55.916393, longitude: 37.755586),
        YMKPoint(latitude: 55.916393, longitude: 37.755586),
        YMKPoint(latitude: 55.915692, longitude: 37.759201),
    ]
  
    private var mapView: YMKMapView = YBaseMapView().mapView
    private lazy var map: YMKMap = mapView.mapWindow.map
    private var pinsCollection: YMKMapObjectCollection?
    private lazy var mapObjectTapListener: YMKMapObjectTapListener = MapObjectTapListener(controller: self)
    
    var tabView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        tabView.delegate = self
        moveMap()
        addCars()
        addUser()
    }
    
    private func moveMap() {
        map.move(
            with: YMKCameraPosition(
                target: Const.point,
                zoom: 5,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
    }
    
    private func addPlacemark(_ map: YMKMap, geometry: YMKPoint) {
        guard let image = UIImage.pointBlack else { return }
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
    
    private func addUser() {
        guard let image = UIImage.user else { return }
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = Const.point
        placemark.setIconWith(image)
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
    
    func cleanUp() {
        coordinator?.coordinatorDidFinish()
    }
}

extension TabBarViewController: TabViewDelegate {
    func profileButtonTapped() {
        presentPopOver()
        if let navVC = coordinator?.navigationController {
            let profileCoordinator = ProfileCoordinator(navigationController: navVC)
            profileCoordinator.start()
        }
    }
    
    func filtersButtonTapped() {
     
    }
    
    func carSearchButtonTapped() {
        
    }
    
    func orderButtonTapped() {
        
    }
    
    func locationButtonTapped() {
//        map.move(
//            with: YMKCameraPosition(
//                target: Const.point,
//                zoom: 10,
//                azimuth: 0,
//                tilt: 0
//            ),
//            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
//            cameraCallback: nil)
        let offset: Float = 100
        let focus = YMKScreenRect(
            topLeft: YMKScreenPoint(x: offset, y: offset),
            bottomRight: YMKScreenPoint(
                x: Float(mapView.mapWindow.width()) - offset,
                y: Float(mapView.mapWindow.height()) - offset * 3
            )
        )
        let geometry = YMKGeometry(polyline: YMKPolyline(points: carsLocation))
        let position = map.cameraPosition(with: geometry, azimuth: 0, tilt: 0, focus: focus)
        map.move(with: position,
                 animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                 cameraCallback: nil)
    }
}

extension TabBarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension TabBarViewController {
    private func presentPopOver() {
        let popOverViewController = PopOverViewController()
        popOverViewController.modalPresentationStyle = .popover
        popOverViewController.preferredContentSize = CGSize(width: 240, height: 64)
        
        guard let presentationVC = popOverViewController.popoverPresentationController else { return }
        presentationVC.delegate = self
        presentationVC.sourceView = tabView
        presentationVC.permittedArrowDirections = .down
        presentationVC.sourceRect = CGRect(x: Int(tabView.bounds.midX) - 140,
                                           y: Int(tabView.bounds.minY - 5),
                                           width: 0,
                                           height: 0)
        present(popOverViewController, animated: true)
    }
}
