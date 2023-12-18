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
    
    private var mapView: YMKMapView = BaseMapView().mapView
    private lazy var map: YMKMap = mapView.mapWindow.map
    private var clusterListener: (YMKClusterListener & YMKClusterTapListener)?
    private var mapObjectTapListener: YMKMapObjectTapListener?
    private var locationManager = CLLocationManager()
    private var carsByService: [CarsharingCompany: [Car]] = [:]
    private var viewModel: MapViewModel
    private var currentZoom: Float = 9
    private var cameraPosition: YMKCameraPosition?
    private var userLocationLayer: YMKUserLocationLayer?
    
    private let fontSize: CGFloat = 16
    private let marginSize: CGFloat = 5
    private let strokeSize: CGFloat = 7
    
    // MARK: - UI
    
    private var tabView = TabBarView()
    private lazy var compasView = MapButtonView(with: UIImage.locationButton ?? UIImage(), radius: 24) { [weak self] in
        self?.locButtonTapped()
    }
    private lazy var plusButton = MapButtonView(with: UIImage.plusButton ?? UIImage(), radius: 12) { [weak self] in
        self?.plusButtonTapped()
    }
    
    private lazy var minusButton = MapButtonView(with: UIImage.minusButton ?? UIImage(), radius: 12) { [weak self] in
        self?.minusButtonTapped()
    }
    
    private lazy var carsharingCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifare)
        collectionView.collectionViewLayout = createLayout()
        return collectionView
    }()
    
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
        locationManager.requestWhenInUseAuthorization()
        
        addSubviews()
        setupLayout()
        
        tabView.delegate = self
        mapObjectTapListener = self
        clusterListener = self
        carsharingCollectionView.delegate = self
        carsharingCollectionView.dataSource = self
        
        initMap()
        viewModel.onRefreshAction = { [weak self] indexPath in
            self?.carsharingCollectionView.reloadItems(at: [indexPath])
        }
//        
//        userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
    }
    
    // MARK: - Private methods
    
    private func initMap() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        map.move(
            with: YMKCameraPosition(
                target: viewModel.userPoint(),
                zoom: currentZoom,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: { [weak self] _ in
                self?.moveMap()
            })
    }
    
    private func moveMap() {
        let offset: Float = 200
        let focus = YMKScreenRect(
            topLeft: YMKScreenPoint(x: offset, y: offset),
            bottomRight: YMKScreenPoint(
                x: Float(mapView.mapWindow.width()) - offset,
                y: Float(mapView.mapWindow.height()) - offset * 2
            )
        )
        
        self.viewModel.carsLocations { [weak self] cars in
            guard let self = self else { return }
            let companies = CarsharingCompany.allCases
            for company in companies {
                let carsInCompany = cars.filter { $0.company == company }
                self.carsByService[company] = carsInCompany
                let coordinates = carsInCompany.map { YMKPoint(latitude: Double($0.coordinates.latitude), longitude: Double($0.coordinates.longitude)) }
                let geometry = YMKGeometry(polyline: YMKPolyline(points: coordinates))
                let position = self.map.cameraPosition(with: geometry, azimuth: 0, tilt: 0, focus: focus)
                self.map.move(
                    with: position,
                    animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0),
                    cameraCallback: nil)
            }
            self.addClustering(with: self.carsByService)
        }
    }
    
    private func addClustering(with cars: [CarsharingCompany: [Car]]) {
        guard let clusterListener else { return }
        let collection = map.mapObjects.addClusterizedPlacemarkCollection(with: clusterListener)
        for company in CarsharingCompany.allCases {
            guard let carsInCompany = carsByService[company] else { continue }
                
            for car in carsInCompany {
                let coordinates = YMKPoint(
                    latitude: Double(car.coordinates.latitude),
                    longitude: Double(car.coordinates.longitude)
                )
                    
                let placemark = collection.addPlacemark()
                placemark.geometry = coordinates
                placemark.setIconWith(company.iconImage, style: YMKIconStyle())
                placemark.userData = car.id
            }
                
            collection.clusterPlacemarks(withClusterRadius: GeometryProvider.clusterRadius, minZoom: GeometryProvider.clusterMinZoom)
        }
        if let mapObjectTapListener {
            collection.addTapListener(with: mapObjectTapListener)
        }
    }
    
    private func locButtonTapped() {
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        
        if userLocationLayer != nil {
            guard let currentPosition = self.locationManager.location else { return }
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

    private func plusButtonTapped() {
        changeZoom(by: 1.0)
    }
    
    private func minusButtonTapped() {
        changeZoom(by: -1.0)

    }
    
    private func changeZoom(by amount: Float) {
        map.move(
            with: YMKCameraPosition(
                target: map.cameraPosition.target,
                zoom: map.cameraPosition.zoom + amount,
                azimuth: map.cameraPosition.azimuth,
                tilt: map.cameraPosition.tilt
            ),
            animation: YMKAnimation(type: .smooth, duration: 1.0)
        )
    }
}

// MARK: - Extension TabViewDelegate

extension MapViewController: TabViewDelegate {
    func profileButtonTapped() {
        viewModel.openProfile()
    }
    
    func filtersButtonTapped() {
        viewModel.openFilters(on: self)
    }
    
    func carSearchButtonTapped() {
        viewModel.openSearchCar(on: self)
    }
}

// MARK: - Extension Layout

extension MapViewController {
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(tabView)
        mapView.addSubview(compasView)
        mapView.addSubview(minusButton)
        mapView.addSubview(plusButton)
        mapView.addSubview(carsharingCollectionView)
    }
    
    private func setupLayout() {
        mapView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        tabView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.equalTo(mapView.snp.leading).offset(21)
            make.trailing.equalTo(mapView.snp.trailing).offset(-21)
            make.bottom.equalTo(mapView.snp.bottom).offset(-50)
        }
        
        compasView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.trailing.equalTo(mapView.snp.trailing).offset(-21)
            make.bottom.equalTo(tabView.snp.top).offset(-72)
        }
        
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.trailing.equalTo(compasView.snp.trailing)
            make.bottom.equalTo(compasView.snp.top).offset(-208)
        }
        
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.trailing.equalTo(compasView.snp.trailing)
            make.bottom.equalTo(minusButton.snp.top).offset(-20)
        }
        
        carsharingCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(tabView.snp.top).offset(-16)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .absolute(40))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 12
            section.contentInsets = .init(top: 0, leading: 21, bottom: 0, trailing: 21)
            return section
        }
    }
}

// MARK: - Extension YMKUserLocationObjectListener

extension MapViewController: YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        guard let image = UIImage(named: "userPoint") else { return }
        view.arrow.setIconWith(image)
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName("userPoint",
            image: UIImage(named: "userPoint")!,
            style: YMKIconStyle(
                anchor: CGPoint(x: 0, y: 0) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil))
        view.accuracyCircle.fillColor = .clear
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
}

// MARK: - Extension YMKMapObjectTapListener

extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let placemark = mapObject as? YMKPlacemarkMapObject else { return false }
        focusOnPlacemark(placemark)
        var selectedCar: Car
        
        for company in CarsharingCompany.allCases {
            guard let carsInCompany = carsByService[company] else { continue }
            for car in carsInCompany where car.id == placemark.userData as? UUID {
                selectedCar = car
                viewModel.openCar(on: self, with: selectedCar)
            }
        }
        return true
    }
        
    func focusOnPlacemark(_ placemark: YMKPlacemarkMapObject) {
        let place = YMKPoint(
            latitude: (placemark.geometry.latitude - 0.0025),
            longitude: placemark.geometry.longitude
        )
            
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: place, zoom: 16, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.4),
            cameraCallback: nil
        )
    }
}

// MARK: - Extension YMKClusterListener, YMKClusterTapListener

extension MapViewController: YMKClusterListener, YMKClusterTapListener {
    func onClusterAdded(with cluster: YMKCluster) {
        cluster.appearance.setIconWith(
            clusterImage(cluster.size).withShadow(
                blur: 3,
                offset: CGSize(width: 1, height: 3),
                color: UIColor.carsharing.blue.withAlphaComponent(0.2),
                size: CGSize(width: 48, height: 48)))
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
        let text = "\(clusterSize as NSNumber)"
        let font = UIFont.systemFont(ofSize: fontSize * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + marginSize * scale
        let externalRadius = internalRadius + strokeSize * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)
        
        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.carsharing.blue.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(
                width: 2 * externalRadius,
                height: 2 * externalRadius)))
        
        ctx.setFillColor(UIColor.carsharing.white.cgColor)
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
                NSAttributedString.Key.foregroundColor: UIColor.carsharing.black])
        guard let imageCluster = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return imageCluster
    }
}

// MARK: Extension UICollectionViewDataSource

extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilterCollectionViewCell.identifare,
            for: indexPath) as? FilterCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        let isSelected = viewModel.filters(for: section).contains(item)
        guard let company = CarsharingCompany(rawValue: item.title) else {
            return UICollectionViewCell()
        }
        cell.configure(
            title: company.name,
            textColor: isSelected ? UIColor.carsharing.white : company.color,
            borderColor: company.color
        )
        cell.backgroundColor = isSelected ? company.color : UIColor.carsharing.white90
        
        return cell
    }
}

// MARK: Extension UICollectionViewDelegate

extension MapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        viewModel.change(item, in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
}
