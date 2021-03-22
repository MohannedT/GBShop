//
//  UILabel + Extension.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .authAndRegisterFont()) {
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = .center
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
