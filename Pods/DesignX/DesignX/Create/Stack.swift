//
//  UIStackView+magic.swift
//  Pods
//
//  Created by Belal Samy on 24/06/2021.
//

import Foundation
import UIKit

public extension UIStackView {
    
    //MARK: - Func - fakeViews
    func fakeViews(_ quantity: Int) -> [UIView] {
        var views = [UIView]()
        (0..<quantity).forEach { _ in
            let view = UIView()
            views.append(view)
        }
        return views
    }
    
    //Enums
    enum axis {
        case H
        case V
    }
    
    enum distribution {
        case equalCentering(CGFloat)
        case equalSpacing(CGFloat)
        case fill(CGFloat)
        case fillEqually(CGFloat)
        case fillProportionally(CGFloat)
        case custom([CGFloat])
        case spacing(CGFloat)
    }

    
    //MARK: - Func - create Stack
    func create(subviews: [UIView], colors: [color], axis: axis?, distribution: distribution?) {
        
        //subviews
        for view in subviews {
            addArrangedSubview(view)
        }
                
        //colors
        for (index, view) in subviews.enumerated() {
            let color = pattern.set(colors, to: index)
        
                switch color {
                case .hex(let hexString):
                    view.backgroundColor = hexStringToUIColor(hex: hexString)
                case .rgb(let R, let G, let B):
                    view.backgroundColor = rgbToUIColor(R: R, G: G, B: B)
                case .color(let color):
                    view.backgroundColor = color
                }
        }
        
        //axis
        if axis != nil {
            switch axis {
            case .H:
                self.axis = .horizontal
            case .V:
                self.axis = .vertical
            case .none:
                ()
            }
        }
      
        //distribution
        if distribution != nil {
            switch distribution {
            case .equalCentering(let spacingValue):
                self.distribution = .equalCentering
                self.spacing = spacingValue
                
            case .equalSpacing(let spacingValue):
                self.distribution = .equalSpacing
                self.spacing = spacingValue
                
            case .fill(let spacingValue):
                self.distribution = .fill
                self.spacing = spacingValue
                
            case .fillEqually(let spacingValue):
                self.distribution = .fillEqually
                self.spacing = spacingValue
                
            case .fillProportionally(let spacingValue):
                self.distribution = .fillProportionally
                self.spacing = spacingValue
                
            case .custom(let ratios):
                var sumOfRatios = CGFloat() // get the sum first
                for (index, _) in subviews.enumerated() {
                    let ratio = pattern.set(ratios, to: index)
                    sumOfRatios = sumOfRatios + ratio
                }
                    
                for (index, view) in subviews.enumerated() {
                    let ratio = pattern.set(ratios, to: index)
                    var percentage = CGFloat()
                    percentage = (ratio / sumOfRatios)
                    
                    //print("percentage >>> \(percentage * 100) %")
                    if self.axis == .vertical {
                        view.constraint(H: .equal(nil, percentage))
                    } else {
                        view.constraint(W: .equal(nil, percentage))
                    }
                }
                
            case .spacing(let spacingValue):
                self.spacing = spacingValue
                
            case .none:
                print("no distribution")
                
            }
        }
    }
    
} // extension
