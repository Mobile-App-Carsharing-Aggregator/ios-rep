//
//  GeometryProvider.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 05.12.2023.
//

import Foundation
import YandexMapsMobile

enum GeometryProvider {
    static let clusterRadius: CGFloat = 60.0
    static let clusterMinZoom: UInt = 15
    static let userPoint = YMKPoint(latitude: 55.755864, longitude: 37.617698)
    static let cameraPosition = YMKCameraPosition(target: userPoint, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
    
    static let carsLocations: [YMKPoint] = [
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
        YMKPoint(latitude: 55.915692, longitude: 37.759201)
    ]
}
