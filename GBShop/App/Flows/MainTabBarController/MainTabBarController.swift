//
//  TabBarController.swift
//  GBShop
//
//  Created by Александр Ипатов on 15.03.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    var analytics: FirebaseAnalytics
    var authService: AuthService
    var user: User
    // MARK: - Init
    init(authService: AuthService, user: User, analytics: FirebaseAnalytics) {
        self.analytics = analytics
        self.authService = authService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let catalogViewController = CatalogCollectionViewController(user: user,
                                                                    requestFactory: authService.requestFactory,
                                                                    analytics: analytics)
        let basketViewController =  BasketViewController(user: user,
                                                         requestFactory: authService.requestFactory,
                                                         analytics: analytics)
        let changeDataViewController = ChangeDataViewController(authService: authService,
                                                                user: user,
                                                                analytics: analytics)
        tabBar.tintColor = .black
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)

        let catalogImage = UIImage(systemName: "table", withConfiguration: boldConfig)!
        let changeDataImage = UIImage(systemName: "person", withConfiguration: boldConfig)!
        let basketImage = UIImage(systemName: "cart", withConfiguration: boldConfig)!

        let catalogImageSelected = UIImage(systemName: "table.fill", withConfiguration: boldConfig)!
        let changeDataImageSelected = UIImage(systemName: "person.fill", withConfiguration: boldConfig)!
        let basketImageSelected = UIImage(systemName: "cart.fill", withConfiguration: boldConfig)!

        viewControllers = [
            generateNavigationController(rootViewController: catalogViewController, title: "Catalog",
                                         image: catalogImage,
                                         selectedImage:
                                            catalogImageSelected),
            generateNavigationController(rootViewController: basketViewController,
                                         title: "Basket",
                                         image: basketImage,
                                         selectedImage: basketImageSelected),
            generateNavigationController(rootViewController: changeDataViewController,
                                         title: "User",
                                         image: changeDataImage,
                                         selectedImage: changeDataImageSelected)
        ]
    }

    private func generateNavigationController(rootViewController: UIViewController,
                                              title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.selectedImage = selectedImage
        navigationVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        return navigationVC
    }

}
