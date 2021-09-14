//
//  shape.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    
        enum Shape {
            case square(size: CGFloat, X: X, Y: Y)
            case circle(size: CGFloat, X: X, Y: Y)
        }

        func shape(_ shape: Shape) {
            self.clipsToBounds = true
            
            switch shape {
            // square
            case .square(let size, let X, let Y):
                constraint(W: .fixed(size), H: .fixed(size))
                constraint(X: X, Y: Y)
            
            // circle
            case .circle(let size, let X, let Y):
                constraint(W: .fixed(size), H: .fixed(size))
                layer.cornerRadius = size / 2
                constraint(X: X, Y: Y)
        }
    }
}
