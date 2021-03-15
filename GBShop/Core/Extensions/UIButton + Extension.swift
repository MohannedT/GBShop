//
//  UIButton + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .authAndRegisterFont(),
                     isShadow: Bool = false) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = 4
        self.translatesAutoresizingMaskIntoConstraints = false
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
