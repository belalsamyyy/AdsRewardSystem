//
//  UILabel+magic.swift
//  Pods
//
//  Created by Belal Samy on 24/06/2021.
//

import Foundation
import UIKit
  
public extension UILabel {
    //MARK:- Func - create
    func create(string: [String], colors: [color], sizes: [CGFloat], weights: [UIFont.Weight], stroke: [CGFloat], alignment: NSTextAlignment) {
        
        let attributedText = NSMutableAttributedString()
        var baseAttributeText = NSAttributedString()
        var otherAttributeText = NSAttributedString()
        
        for (index, t) in string.enumerated() {
            let color = pattern.set(colors, to: index)
            let size = pattern.set(sizes, to: index)
            let weight = pattern.set(weights, to: index)
            let stroke = pattern.set(stroke, to: index)
            
            // color value
            var colorValue: UIColor

            switch color {
            case .hex(let hexString):
                colorValue = hexStringToUIColor(hex: hexString)

            case .rgb(let R, let G, let B):
                colorValue = rgbToUIColor(R: R, G: G, B: B)
                
            case .color(let color):
                colorValue = color
            }
    
            
            if index == 0 {
                baseAttributeText = NSAttributedString(string: t, attributes: [.foregroundColor: colorValue, .font: UIFont.systemFont(ofSize: size, weight: weight), .strokeColor: colorValue, .strokeWidth: stroke])
                attributedText.append(baseAttributeText)
                
            } else {
                otherAttributeText = NSAttributedString(string: t, attributes: [.foregroundColor: colorValue, .font: UIFont.systemFont(ofSize: size, weight: weight), .strokeColor: colorValue, .strokeWidth: stroke])
                attributedText.append(otherAttributeText)
            }
        }
        
        self.numberOfLines = 0
        self.textAlignment = alignment
        self.attributedText = attributedText
    }

}


public extension UIView {
    //MARK:- Func - labelit
    func labelIt(_ text: String, _ size: CGFloat = 100, _ color: UIColor = .black) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = color
        label.textAlignment = .center
        self.addSubview(label)
        label.frame = self.frame // didnt support ladscape orientation >> didLayoutSubviews
    }
}
