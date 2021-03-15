//
//  UITextField + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit
extension UITextField {
    convenience init(placeholder: String? = "", isSecure: Bool = false, isChangeData: Bool = false) {
        self.init()
        self.clearButtonMode = .whileEditing
        self.placeholder = placeholder
        self.adjustsFontSizeToFitWidth = true
        self.borderStyle = .roundedRect
        self.font = .authAndRegisterFont()
        self.isSecureTextEntry = isSecure
        self.translatesAutoresizingMaskIntoConstraints = false
        if isChangeData {
        // self.attributedPlaceholder = NSAttributedString(string: placeholder,
         //                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // self.text = placeholder
            self.placeholder = nil
        }
    }
}
