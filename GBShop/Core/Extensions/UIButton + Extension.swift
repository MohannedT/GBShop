//
//  UIButton + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     image: UIImage? = nil,
                     titleColor: UIColor = .black,
                     backgroundColor: UIColor,
                     cornerRadius: CGFloat = 4,
                     font: UIFont? = .authAndRegisterFont(),
                     isShadow: Bool = false,
                     isBorder: Bool = false,
                     accessibilityIdentifier: String? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = .white
        self.accessibilityIdentifier = accessibilityIdentifier
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        if isBorder {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
        }
    }
    convenience init(starButton: Bool) {
        self.init(type: .system)
        if starButton {
        self.setImage( UIImage(systemName: "star"), for: .normal)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        }
    }
}
