//
//  Stroke.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    // stroke
    func stroke(color: color, width: CGFloat) {
        layer.borderWidth = width

        switch color {
        case .hex(let hexString):
            layer.borderColor = hexStringToUIColor(hex: hexString).cgColor

        case .rgb(let R, let G, let B):
            layer.borderColor = rgbToUIColor(R: R, G: G, B: B).cgColor
            
        case .color(let color):
            layer.borderColor = color.cgColor
        }
        
    }
}
