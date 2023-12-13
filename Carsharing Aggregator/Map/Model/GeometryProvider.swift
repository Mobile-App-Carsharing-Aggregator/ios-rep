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
    static let userPoint = YMKPoint(latitude: 55.714788, longitude: 37.565668)
    static let cameraPosition = YMKCameraPosition(
        target: userPoint,
        zoom: 17.0,
        azimuth: 150.0,
        tilt: 0)
}
