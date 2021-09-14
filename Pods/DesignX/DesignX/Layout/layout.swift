//
//  UIView.swift
//  PexelsClone
//
//  Created by Belal Samy on 2/4/21.
//  Copyright © 2021 Belal Samy. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - (1) XWYH
    func layout(X: X, W: W, Y: Y, H: H) {
        constraint(X: X)
        constraint(W: W)
        constraint(Y: Y)
        constraint(H: H)
    }
    
    //MARK: - (2) XW, Y, H
    func layout(XW: XW, Y: Y, H: H) {
        constraint(XW: XW)
        constraint(Y: Y)
        constraint(H: H)
    }
    
    //MARK: - (3) X, W, YH
    func layout(X: X, W: W, YH: YH) {
        constraint(X: X)
        constraint(W: W)
        constraint(YH: YH)
    }
    
    //MARK: - (4) XW, YH
    func layout(XW: XW, YH: YH) {
        constraint(XW: XW)
        constraint(YH: YH)
    }
    
    //MARK: - (5) Shortcuts for common Scenarios
    func layout(shortcut: Shortcut) {
        switch shortcut {
        
        case .fillSuperView(let value):
            layout(XW: .leadingAndCenter(nil, value), YH: .topAndCenter(nil, value))
            
        case .fillToSafeArea(let view1, let value1, let view2, let value2):
            layout(XW: .leadingAndCenter(nil, 0), YH: .TopAndBottomBothToSafeArea(view1, value1, view2, value2))

        }
    }
    
    //MARK: - Enums
    
    enum X {
        case leading(UIView?, CGFloat) // nil = superview
        case trailing(UIView?, CGFloat) // nil = superview
        case center(UIView?) // nil = superview
        // safeArea
        case leadingToSafeArea(UIView?, CGFloat)
        case trailingToSafeArea(UIView?, CGFloat)
    }
    
    enum W {
        case wrapContent
        case fixed(CGFloat)
        case equal(UIView?, CGFloat) // nil = superview
    }
    
    enum Y {
       case top(UIView?, CGFloat) // nil = superview
       case bottom(UIView?, CGFloat) // nil = superview
       case center(UIView?) // nil = superview
        // safeArea
       case topToSafeArea(UIView?, CGFloat)
       case bottomToSafeArea(UIView?, CGFloat)

    }
    
    enum H {
       case wrapContent
       case fixed(CGFloat)
       case equal(UIView?, CGFloat) // nil = superview
    }
    
    enum XW {
        case leadingAndCenter(UIView?, CGFloat) // nil = superview
        case trailingAndCenter(UIView?, CGFloat) // nil = superview
        case leadingAndTrailing(UIView?, CGFloat, UIView?, CGFloat) // nil = superview
        case leadingAndTrailingAndWidth(UIView?, CGFloat, UIView?, CGFloat, W) // nil = superview
        // safeArea
        case leadingAndTrailingBothToSafeArea(UIView?, CGFloat, UIView?, CGFloat) // nil = superview
        case leadingToSafeAreaAndTrailingAndWidth(UIView?, CGFloat, UIView?, CGFloat, W) // nil = superview
        case leadingAndTrailingToSafeAreaAndWidth(UIView?, CGFloat, UIView?, CGFloat, W) // nil = superview
    }
    
    enum YH {
        case topAndCenter(UIView?, CGFloat) // nil = superview
        case bottomAndCenter(UIView?, CGFloat) // nil = superview
        case TopAndBottom(UIView?, CGFloat, UIView?, CGFloat) // nil = superview
        case TopAndBottomAndHeight(UIView?, CGFloat, UIView?, CGFloat, H) // nil = superview
        // safeArea
        case TopAndBottomBothToSafeArea(UIView?, CGFloat, UIView?, CGFloat) // nil = superview
        case TopToSafeAreaAndBottomAndHeight(UIView?, CGFloat, UIView?, CGFloat, H) // nil = superview
        case TopAndBottomToSafeAreaAndHeight(UIView?, CGFloat, UIView?, CGFloat, H) // nil = superview
    }
    
    enum Shortcut {
        case fillSuperView(CGFloat)
        case fillToSafeArea(UIView?, CGFloat, UIView?, CGFloat) // nil = superview
    }
    
} // extention


