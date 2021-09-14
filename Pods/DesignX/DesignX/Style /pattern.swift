//
//  UITextField + magic.swift
//  Pods
//
//  Created by Belal Samy on 01/07/2021.
//

import Foundation
import UIKit

//MARK:- MagicPattern
public enum PatternType {
    case repeated
    case reverse
    case random
    case last
}

public class pattern {
    static func set<P>(_ arrOfProperty: [P], _ patternType: PatternType = .repeated, to index: Int) -> P {
        var property: P
        var patternIndex = 0
        
        switch patternType {
        case .repeated:
            let originalIndex = index - arrOfProperty.count * ( index / arrOfProperty.count )
            patternIndex = originalIndex
            
        case .reverse:
            let originalIndex = index - arrOfProperty.count * ( index / arrOfProperty.count )
            let reverseIndex = (index / arrOfProperty.count) % 2 == 0 ? originalIndex : arrOfProperty.count - 1 - originalIndex
            patternIndex = reverseIndex
            
        case .random:
            let randomIndex = Int.random(in: 0..<arrOfProperty.count)
            patternIndex = randomIndex
            
        case .last:
            let lastIndex = arrOfProperty.count - 1
            patternIndex = lastIndex
        }
          

        property = arrOfProperty.count - 1 < index ? arrOfProperty[patternIndex] : arrOfProperty[index]
        return property
    }
}
