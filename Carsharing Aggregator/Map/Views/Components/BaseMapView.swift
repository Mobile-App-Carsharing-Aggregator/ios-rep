//
//  BaseMapView.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 27.11.2023.
//

fileprivate struct ApiKey {
    #warning("press api here:")
    static let apiKey = "1234567"
}

import UIKit
import YandexMapsMobile

class BaseMapView: UIView {
    
    // MARK: - Public properties
    
    @objc public var mapView: YMKMapView!

    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        YMKMapKit.setApiKey("\(ApiKey.apiKey)")
        YMKMapKit.setLocale("ru_RU")
        YMKMapKit.sharedInstance().onStart()
        setup()
    }

    // MARK: - Methods
    
    private func setup() {
        // OpenGl is deprecated under M1 simulator, we should use Vulkan
        mapView = YMKMapView(frame: bounds, vulkanPreferred: BaseMapView.isM1Simulator())
        mapView.mapWindow.map.mapType = .map
    }

    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
}
