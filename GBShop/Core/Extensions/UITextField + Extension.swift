//
//  UITextField + Ext.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String? = "",
                     isSecure: Bool = false,
                     isChangeData: Bool = false,
                     accessibilityIdentifier: String? = nil) {
        self.init()
        self.clearButtonMode = .whileEditing
        self.placeholder = placeholder
        self.adjustsFontSizeToFitWidth = true
        self.borderStyle = .roundedRect
        self.accessibilityIdentifier = accessibilityIdentifier
        self.font = .authAndRegisterFont()
        self.isSecureTextEntry = isSecure
        self.translatesAutoresizingMaskIntoConstraints = false
        if isChangeData {
            self.placeholder = nil
        }
    }
}
