//
//  rotate.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}
