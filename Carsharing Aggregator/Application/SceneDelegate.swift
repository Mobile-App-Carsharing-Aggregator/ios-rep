//
//  SceneDelegate.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 15.11.2023.
//

import UIKit
import YandexMapsMobile

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if let token = TokenStorage.shared.getToken() {
            print("Сохранен токен: \(token)")
        } else {
            print("Сохраненного токена не обнаружено")
        }
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator.start()
        YMKMapKit.setLocale("ru_RU")
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
