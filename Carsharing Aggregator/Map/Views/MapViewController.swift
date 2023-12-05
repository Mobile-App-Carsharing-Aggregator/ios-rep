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
    
    // MARK: - Properties
    
    private var collection: YMKClusterizedPlacemarkCollection!
    private var mapView: YMKMapView = BaseMapView().mapView
    private lazy var map: YMKMap = mapView.mapWindow.map
    private var clusterListener: (YMKClusterListener & YMKClusterTapListener)?
    private var mapObjectTapListener: YMKMapObjectTapListener?
    private let fontSize: CGFloat = 15
    private let marginSize: CGFloat = 3
    private let strokeSize: CGFloat = 3
    var viewModel: MapViewModel
    var tabView = TabBarView()
    
    // MARK: - LifeCycle
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        
        tabView.delegate = self
        mapObjectTapListener = self
        clusterListener = self
        
        addUser()
        addClustering()
        initMap()
    }
    
    // MARK: - Private methods
    
    private func initMap() {
        map.move(
            with: YMKCameraPosition(
                target: viewModel.userPoint(),
                zoom: 9,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: { [weak self] _ in
                self?.moveMap()
            })
    }
    
    private func moveMap() {
        let offset: Float = 100
        let focus = YMKScreenRect(
            topLeft: YMKScreenPoint(x: offset, y: offset),
            bottomRight: YMKScreenPoint(
                x: Float(mapView.mapWindow.width()) - offset,
                y: Float(mapView.mapWindow.height()) - offset * 3
            )
        )
        let geometry = YMKGeometry(polyline: YMKPolyline(points: viewModel.carsLocations()))
        let position = map.cameraPosition(with: geometry, azimuth: 0, tilt: 0, focus: focus)
        map.move(
            with: position,
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0),
            cameraCallback: nil)
    }
    
    private func addClustering() {
        guard let image = UIImage.pointBlack,
        let clusterListener else { return }
        collection = map.mapObjects.addClusterizedPlacemarkCollection(with: clusterListener)
        collection.addPlacemarks(with: viewModel.carsLocations(), image: image, style: YMKIconStyle())
        collection.clusterPlacemarks(withClusterRadius: GeometryProvider.clusterRadius, minZoom: GeometryProvider.clusterMinZoom)
        if let mapObjectTapListener {
            collection.addTapListener(with: mapObjectTapListener)
        }
    }
    
    private func addUser() {
        guard let image = UIImage.user else { return }
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = viewModel.userPoint()
        placemark.setIconWith(image)
    }
}

extension MapViewController: TabViewDelegate {
    func profileButtonTapped() {
        viewModel.openProfile()
    }
    
    func filtersButtonTapped() {
        
    }
    
    func carSearchButtonTapped() {
        
    }
    
    func orderButtonTapped() {
        
    }
    
    func locationButtonTapped() {
        map.move(
            with: YMKCameraPosition(
                target: viewModel.userPoint(),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: nil)
    }
}

extension MapViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MapViewController {
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

extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        print("Tapped point \((point.latitude, point.longitude))")
        return true
    }
}

extension MapViewController: YMKClusterListener, YMKClusterTapListener {
        func onClusterAdded(with cluster: YMKCluster) {
            cluster.appearance.setIconWith(clusterImage(cluster.size))
            cluster.addClusterTapListener(with: self)
        }
        
        func onClusterTap(with cluster: YMKCluster) -> Bool {
            print("Tapped cluster with \(cluster.size) items")
            // We return true to notify map that the tap was handled and shouldn't be
            // propagated further.
            return true
        }
        
        func clusterImage(_ clusterSize: UInt) -> UIImage {
            let scale = UIScreen.main.scale
            let text = "+ \(clusterSize as NSNumber)"
            let font = UIFont.systemFont(ofSize: fontSize * scale)
            let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
            let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
            let internalRadius = textRadius + marginSize * scale
            let externalRadius = internalRadius + strokeSize * scale
            let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)
            
            UIGraphicsBeginImageContext(iconSize)
            let ctx = UIGraphicsGetCurrentContext()!
            
            ctx.setFillColor(UIColor.purple.cgColor)
            ctx.fillEllipse(in: CGRect(
                origin: .zero,
                size: CGSize(
                    width: 2 * externalRadius,
                    height: 2 * externalRadius)))
            
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fillEllipse(in: CGRect(
                origin: CGPoint(x: externalRadius - internalRadius, y: externalRadius - internalRadius),
                size: CGSize(
                    width: 2 * internalRadius,
                    height: 2 * internalRadius)))
            
            (text as NSString).draw(
                in: CGRect(
                    origin: CGPoint(x: externalRadius - size.width / 2, y: externalRadius - size.height / 2),
                    size: size),
                withAttributes: [
                    NSAttributedString.Key.font: font,
                    NSAttributedString.Key.foregroundColor: UIColor.black])
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            return image
        }
    }
