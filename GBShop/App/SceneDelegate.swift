//
//  SceneDelegate.swift
//  GBShop
//
//  Created by Александр Ипатов on 09.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var analitics = FirebaseAnalytics()
    var requestFactory = RequestFactory()
    var authService: AuthService?

        func scene(_ scene: UIScene,
                   willConnectTo session: UISceneSession,
                   options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.overrideUserInterfaceStyle = .light
            window?.windowScene = windowScene
            authService = AuthService(requestFactory: requestFactory)
            window?.rootViewController = AuthViewController(authService: authService!, analytics: analitics)
            window?.makeKeyAndVisible()
        }

}
