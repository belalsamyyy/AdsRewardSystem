//
//  corner.swift
//  APIManager
//
//  Created by Belal Samy on 25/08/2021.
//

import Foundation
import UIKit

public extension UIView {
    
    enum CornersEnum {
        case all
        case specify(CACornerMask)
    }
    
   func corners(_ type: CornersEnum, radius: CGFloat) {
       layer.masksToBounds = true
       
       switch type {
       case .all:
           layer.cornerRadius = radius
           
       case .specify(let corners):
           layer.cornerRadius = radius
           layer.maskedCorners = corners
           
           // min = left   +   min = top
           // max = right  +   max = right
       }
       

   }
}




