//
//  String+Extensions.swift
//  AdsRewardSystem
//
//  Created by Belal Samy on 13/09/2021.
//

import Foundation

extension String {
    var youtubeID: String? {
    let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let range = NSRange(location: 0, length: count)
        
   guard let result = regex?.firstMatch(in: self, range: range) else {
      return nil
   }
   return (self as NSString).substring(with: result.range)
   }
}
