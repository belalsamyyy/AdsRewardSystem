//
//  Int+Extensions.swift
//  AdsRewardSystem
//
//  Created by Belal Samy on 13/09/2021.
//

import Foundation

extension Int {
    
    func twoDigits() -> String {
        return String(format: "%02d", self)
    }
    
    func toMinutes() -> Int {
        return self * 60 + 1
    }
}

