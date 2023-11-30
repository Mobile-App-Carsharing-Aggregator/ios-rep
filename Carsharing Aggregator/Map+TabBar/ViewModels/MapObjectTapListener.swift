//
//  MapObjectTapListener.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 28.11.2023.
//

import UIKit
import YandexMapsMobile

final class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
    
    private weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        print("Tapped point \((point.latitude, point.longitude))")
        return true
    }
}
