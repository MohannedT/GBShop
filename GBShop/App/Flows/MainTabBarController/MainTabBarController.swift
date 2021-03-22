//
//  TabBarController.swift
//  GBShop
//
//  Created by Александр Ипатов on 15.03.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    var authService: AuthService
    var user: User

    init(authService: AuthService, user: User) {
        self.authService = authService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let catalogViewController = CatalogCollectionViewController(user: user, requestFactory: authService.requestFactory)

        let changeDataViewController = ChangeDataViewController(authService: authService,user: user )

        tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let changeDataImage = UIImage(systemName: "person", withConfiguration: boldConfig)!
        let changeDataImageSelected = UIImage(systemName: "person.fill", withConfiguration: boldConfig)!
        let catalogImage = UIImage(systemName: "table", withConfiguration: boldConfig)!
        let catalogImageSelected = UIImage(systemName: "table.fill", withConfiguration: boldConfig)!
        viewControllers = [     generateNavigationController(rootViewController: catalogViewController, title: "Catalog",
                                                             image: catalogImage,
                                                             selectedImage:
                                                                catalogImageSelected),
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
