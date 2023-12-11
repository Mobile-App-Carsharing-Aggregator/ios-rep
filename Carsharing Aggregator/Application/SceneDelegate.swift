//
//  SceneDelegate.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 15.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let coord = SearchCarCoordinator(navigationController: navigationController)
        coord.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
//        let rootCoordinator = RootCoordinator(navigationController: navigationController)
//        rootCoordinator.start()
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
    }
}
