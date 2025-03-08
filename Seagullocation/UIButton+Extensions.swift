//
//  UIButton+Extensions.swift
//  Seagullocation
//
//  Created by Kadir Emre Yıldırım on 8.03.2025.
//

import UIKit

extension UIButton {
    func addShadow(
        shadowProperties: ButtonShadowProperties
    ) {
        self.layer.shadowColor = shadowProperties.color
        self.layer.shadowOpacity = shadowProperties.opacity
        self.layer.shadowOffset = CGSize(width: shadowProperties.width, height: shadowProperties.height)
        self.layer.shadowRadius = shadowProperties.radius
    }
}
