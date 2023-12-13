//
//  SelectedCarViewController.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 13.12.2023.
//

import UIKit

final class SelectedCarViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newview = UIView(frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        
        newview.backgroundColor = .purple
        newview.layer.cornerRadius = 10
            
        self.view.addSubview(newview)
    }
}

// для перехода
/* func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
 print("Tapped point \((point.latitude, point.longitude))")
 
 let vc = SelectedCarViewController()
 let navVC = UINavigationController(rootViewController: vc)
 navVC.modalPresentationStyle = .custom
 navVC.preferredContentSize = CGSize(width: 400, height: 600)
 controller?.present(navVC, animated: true)
 
 return true
}*/
