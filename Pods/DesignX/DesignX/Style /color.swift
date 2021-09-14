//
//  color.swift
//  APIManager
//
//  Created by Belal Samy on 27/08/2021.
//

import Foundation
import UIKit

public enum color {
    case hex(String)
    case rgb(CGFloat, CGFloat, CGFloat)
    case color(UIColor)
}
    
//MARK: - RGB color
func rgbToUIColor (R: CGFloat, G: CGFloat, B: CGFloat) -> UIColor {
    return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: CGFloat(1.0))
}

//MARK: - hex color
func hexStringToUIColor (hex: String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

