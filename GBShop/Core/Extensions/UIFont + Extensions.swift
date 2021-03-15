//
//  UIFont + Extensions.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UIFont {
    static func logoFont() -> UIFont? {
        return UIFont.init(name: "Thonburi", size: 25)
    }
    static func authAndRegisterFont() -> UIFont? {
        return UIFont.init(name: "Thonburi", size: 20)
    }
    static func infoTextFont() -> UIFont? {
        return UIFont.init(name: "Thonburi", size: 15)
    }
    static func priceFont() -> UIFont? {
        return UIFont.init(name: "Thonburi", size: 18)
    }
}
