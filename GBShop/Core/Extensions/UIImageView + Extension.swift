//
//  UIImageView + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 09.03.2021.
//

import UIKit

extension UIImageView {
    convenience init(systemImageName: String) {
        self.init()
        self.image = UIImage(systemName: systemImageName)
        self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = .black
}
}
