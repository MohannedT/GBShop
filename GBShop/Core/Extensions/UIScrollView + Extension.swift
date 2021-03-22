//
//  UIScrollView + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UIScrollView {
    convenience init(isScrollEnabled: Bool) {
        self.init()
        self.isScrollEnabled = isScrollEnabled
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
}
}
