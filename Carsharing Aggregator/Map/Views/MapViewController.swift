//
//  MapViewController.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 27.11.2023.
//

import UIKit
import YandexMapsMobile
import SnapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var map: YMKMap = mapView.mapWindow.map
    private var mapView: YMKMapView = BaseMapView().mapView
    private var clusterListener: (YMKClusterListener & YMKClusterTapListener)?
    private var mapObjectTapListener: YMKMapObjectTapListener?
    private var userLocation: YMKUserLocationObjectListener?
    private var userLocationLayer: YMKUserLocationLayer?
 
    private let fontSize: CGFloat = 15
    private let marginSize: CGFloat = 5
    private let strokeSize: CGFloat = 5
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
        userLocation = self
        
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
        let collection = map.mapObjects.addClusterizedPlacemarkCollection(with: clusterListener)
        collection.addPlacemarks(with: viewModel.carsLocations(), image: image, style: YMKIconStyle())
        collection.clusterPlacemarks(withClusterRadius: GeometryProvider.clusterRadius, minZoom: GeometryProvider.clusterMinZoom)
        if let mapObjectTapListener {
            collection.addTapListener(with: mapObjectTapListener)
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

// MARK: - Extension TabViewDelegate

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
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        
        mapView.mapWindow.map.isRotateGesturesEnabled = false
            
        if let userLocationLayer {
            guard let currentPosition = locationManager.location else { return }
            let point = YMKPoint(latitude: currentPosition.coordinate.latitude, longitude: currentPosition.coordinate.longitude)
            mapView.mapWindow.map.move(
                with: YMKCameraPosition(target: point, zoom: 15, azimuth: 0, tilt: 0))
        } else {
            let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
            self.userLocationLayer = userLocationLayer
            userLocationLayer.setVisibleWithOn(true)
            userLocationLayer.isHeadingEnabled = true
            userLocationLayer.setAnchorWithAnchorNormal(
                CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
                anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
            
            userLocationLayer.setObjectListenerWith(self)
            mapView.mapWindow.map.move(with:
                YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 15, azimuth: 0, tilt: 0))
        }
    }
}

// MARK: - Extension UIPopoverPresentationControllerDelegate

extension MapViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

// MARK: - Extension Layout

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
}

// MARK: - Extension YMKMapObjectTapListener

extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        print("Tapped point \((point.latitude, point.longitude))")
        return true
    }
}

// MARK: - Extension YMKClusterListener, YMKClusterTapListener

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
            ctx.setFillColor(UIColor(named: "pupleOpacity")?.cgColor ?? UIColor.black.cgColor)
            ctx.fillEllipse(in: CGRect(
                origin: .zero,
                size: CGSize(
                    width: 2 * externalRadius,
                    height: 2 * externalRadius)))
        
            ctx.setFillColor(UIColor.purple.cgColor)
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
                    NSAttributedString.Key.foregroundColor: UIColor.white])
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            image.withTintColor(UIColor.white)
            return image
        }
    }

 // MARK: - Extension YMKUserLocationObjectListener

extension MapViewController: YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        let pinPlacemark = view.pin.useCompositeIcon()
        guard let pinGradient = UIImage(named: "pinGradient") else { return }
        pinPlacemark.setIconWithName(
            "pin",
            image: pinGradient,
            style: YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 1,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil))
        view.accuracyCircle.fillColor = UIColor.clear
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
       
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
}
