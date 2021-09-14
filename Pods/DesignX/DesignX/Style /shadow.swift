//
//  shadow.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    func shadow(container: UIView, color: color, opacity: Float = 0.5, H: CGFloat = 20, W: CGFloat = 20, radius: CGFloat = 20, scale: Bool = true) {
    
        container.addSubview(self)
        container.layer.masksToBounds = false

        switch color {
        case .hex(let hexString):
            container.layer.shadowColor = hexStringToUIColor(hex: hexString).cgColor

        case .rgb(let R, let G, let B):
            container.layer.shadowColor = rgbToUIColor(R: R, G: G, B: B).cgColor
            
        case .color(let color):
            container.layer.shadowColor = color.cgColor
        }

        container.layer.cornerRadius = radius
        container.layer.shadowOpacity = opacity
        container.layer.shadowOffset = CGSize(width: W, height: H)
        container.layer.shadowRadius = radius

        self.frame = container.bounds
        self.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
}

