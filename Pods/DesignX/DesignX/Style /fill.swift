//
//  Fill.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    
// MARK: - to make gradient layer change dynamically when orientation changes
//    var gradientlayer = CAGradientLayer()
//
//    override func viewDidLayoutSubviews() {
//        gradientlayer.frame = view.bounds
//    }

    func fill(gradient: [color], locations: [NSNumber], opacity: CGFloat) -> CAGradientLayer {
        alpha = opacity

        let gradientLayer = CAGradientLayer()

        // turn colors into cgcolors
        var CGColors = [CGColor]()

        gradient.forEach { color in
            switch color {
            case .hex(let hexString):
                CGColors.append(hexStringToUIColor(hex: hexString).cgColor)
            case .rgb(let R, let G, let B):
                CGColors.append(rgbToUIColor(R: R, G: G, B: B).cgColor)
            case .color(let color):
                CGColors.append(color.cgColor)
            }
        }

        // Add colors and locations
        gradientLayer.colors = CGColors
        gradientLayer.locations = locations

        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)

        return gradientLayer
    }
    
    
    func fill(color: color, opacity: CGFloat) {
        alpha = opacity

        switch color {
        case .hex(let hexString):
            backgroundColor = hexStringToUIColor(hex: hexString)

        case .rgb(let R, let G, let B):
            backgroundColor = rgbToUIColor(R: R, G: G, B: B)
            
        case .color(let color):
            backgroundColor = color
        }
        
    }
    
    
    func fill(image: String = "YOUR DEFAULT IMAGE NAME", contentMode: UIView.ContentMode = .scaleToFill) {
       // setup the UIImageView
       let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
       backgroundImageView.image = UIImage(named: image)
       backgroundImageView.contentMode = contentMode
       backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

       addSubview(backgroundImageView)
       sendSubviewToBack(backgroundImageView)
       backgroundImageView.layout(shortcut: .fillSuperView(1))
   }
}


