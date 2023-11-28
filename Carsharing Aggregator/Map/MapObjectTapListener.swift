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
        AlertPresenter.present(
            from: controller,
            with: "Tapped point",
            message: "\((point.latitude, point.longitude))"
        )
        print("Tapped point \((point.latitude, point.longitude))")
        return true
    }
}

enum AlertPresenter {
    static func present(from controller: UIViewController?, with text: String, message: String? = nil) {
        guard let controller = controller else {
            return
        }
        let alertVC = UIAlertController(title: text, message: message, preferredStyle: .actionSheet)
        controller.present(alertVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alertVC.dismiss(animated: true)
        }
    }
}
