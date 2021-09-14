//
//  UIView+individualConstriants.swift
//  PexelsClone
//
//  Created by Belal Samy on 2/7/21.
//  Copyright © 2021 Belal Samy. All rights reserved.
//

import UIKit

public extension UIView {
    
    func constraint(W: W, H: H) {
        translatesAutoresizingMaskIntoConstraints = false
        setW(W: W)
        setH(H: H)
    }
       
   func constraint(X: X, Y: Y) {
         translatesAutoresizingMaskIntoConstraints = false
         setX(X: X)
         setY(Y: Y)
   }
   
   func constraint(X: X) {
        translatesAutoresizingMaskIntoConstraints = false
        setX(X: X)
    }
   
   func constraint(W: W) {
        translatesAutoresizingMaskIntoConstraints = false
        setW(W: W)
    }
   
   func constraint(Y: Y) {
        translatesAutoresizingMaskIntoConstraints = false
        setY(Y: Y)
    }
   
   func constraint(H: H) {
        translatesAutoresizingMaskIntoConstraints = false
        setH(H: H)
    }
   
   func constraint(XW: XW) {
    translatesAutoresizingMaskIntoConstraints = false
    setXW(XW: XW)
   }
   
   func constraint(YH: YH) {
   translatesAutoresizingMaskIntoConstraints = false
   setYH(YH: YH)
   }

    
    //MARK: - Reusable Functions
    private func setW(W: W) {
        switch W {
        case .wrapContent:
            self.autoresizingMask = .flexibleWidth
//               let targetSize = CGSize(width: 10000, height: frame.width) // make the width very big
//               let estimatedSize = self.systemLayoutSizeFitting(targetSize)
//               self.widthAnchor.constraint(equalToConstant: estimatedSize.width).isActive = true
                  
         case .fixed(let value):
           if value != 0 {
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
           }
            
        case .equal(let view, let multiplier):
            if let view = view {
               self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
            } else {
               self.widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: multiplier).isActive = true
            }
        }
    }
    
    private func setH(H: H) {
        switch H {
        case .wrapContent:
            self.autoresizingMask = .flexibleHeight
//               let targetSize = CGSize(width: frame.width, height: 10000) // make the height very big
//               let estimatedSize = self.systemLayoutSizeFitting(targetSize)
//               heightAnchor.constraint(equalToConstant: estimatedSize.height).isActive = true
            
         case .fixed(let value):
           if value != 0 {
            heightAnchor.constraint(equalToConstant: value).isActive = true
           }
            
         case .equal(let view, let multiplier):
           if let view = view {
               self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
           } else {
               self.heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: multiplier).isActive = true
           }

        }
    }
    
    private func setX(X: X) {
        switch X {
        case .leading(let view, let value):
            setLeading(view: view, value: value)
            
        case .trailing(let view, let value):
            setTrailing(view: view, value: value)
            
        case .center(let view):
           setCenterX(view: view)
    
        case .leadingToSafeArea(let view, let value):
            setLeadingToSafeArea(view: view, value: value)
           
        case .trailingToSafeArea(let view, let value):
            setTrailingToSafeArea(view: view, value: value)
        }
    }
    
    private func setY(Y: Y) {
        switch Y {
        case .top(let view, let value):
            setTop(view: view, value: value)
            
        case .bottom(let view, let value):
           setBottom(view: view, value: value)
            
        case .center(let view):
          setCenterY(view: view)

        case .topToSafeArea(let view, let value):
            setTopToSafeArea(view: view, value: value)
            
        case .bottomToSafeArea(let view, let value):
           setBottomToSafeArea(view: view, value: value)
        }
    }
    
    private func setXW(XW: XW) {
        switch XW {
        case .leadingAndCenter(let view, let value):
            // leading and center
            setLeading(view: view, value: value)
            setCenterX(view: view)

        case .trailingAndCenter(let view, let value):
            // trailing and center
           setTrailing(view: view, value: value)
           setCenterX(view: view)
         
        case .leadingAndTrailing(let view1, let value1, let view2, let value2):
            // leading and trailing
          setLeading(view: view1, value: value1)
          setTrailing(view: view2, value: value2)
        
        case .leadingAndTrailingAndWidth(let view1, let value1, let view2, let value2, let W):
            // leading and trailing and width
           setLeading(view: view1, value: value1)
           setTrailing(view: view2, value: value2)
           setW(W: W)
            
        case .leadingAndTrailingBothToSafeArea(let view1, let value1, let view2, let value2):
            // leading and trailing both to Safe area
            setLeadingToSafeArea(view: view1, value: value1)
            setTrailingToSafeArea(view: view2, value: value2)
         
        case .leadingToSafeAreaAndTrailingAndWidth(let view1, let value1, let view2, let value2, let W):
            // leading to Safe area and trailing and width
           setLeadingToSafeArea(view: view1, value: value1)
           setTrailing(view: view2, value: value2)
           setW(W: W)

        case .leadingAndTrailingToSafeAreaAndWidth(let view1, let value1, let view2, let value2, let W):
            // leading and trailing to safe area and width
           setLeading(view: view1, value: value1)
           setTrailingToSafeArea(view: view2, value: value2)
           setW(W: W)
        }
    }
    
    private func setYH(YH: YH) {
        switch YH {
         case .topAndCenter(let view, let value):
            // top and center
            setTop(view: view, value: value)
            setCenterY(view: view)
            
         case .bottomAndCenter(let view, let value):
            // bottom and center
            setBottom(view: view, value: value)
            setCenterY(view: view)
            
         case .TopAndBottom(let view1, let value1, let view2, let value2):
            // top and bottom
            setTop(view: view1, value: value1)
            setBottom(view: view2, value: value2)
     
         case .TopAndBottomAndHeight(let view1, let value1, let view2, let value2, let H):
            // top and bottom and heigth
            setTop(view: view1, value: value1)
            setBottom(view: view2, value: value2)
            setH(H: H)
              
        case .TopAndBottomBothToSafeArea(let view1, let value1, let view2, let value2):
            // top and bottom both to safe area
           setTopToSafeArea(view: view1, value: value1)
           setBottomToSafeArea(view: view2, value: value2)

        case .TopToSafeAreaAndBottomAndHeight(let view1, let value1, let view2, let value2, let H):
            // top to safe area and bottom and heigth
            setTopToSafeArea(view: view1, value: value1)
            setBottom(view: view2, value: value2)
            setH(H: H)


        case .TopAndBottomToSafeAreaAndHeight(let view1, let value1, let view2, let value2, let H):
            // top and bottom to safe area and height
            setTop(view: view1, value: value1)
            setBottomToSafeArea(view: view2, value: value2)
            setH(H: H)
        }
    }
    
    
    //MARK: - Reusable Functions for reusable Functions
    
    private func setLeading(view: UIView?, value: CGFloat) {
        if let view = view {
            self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: value).isActive = true
        } else {
            self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: value).isActive = true
        }
    }
    
    private func setTrailing(view: UIView?, value: CGFloat) {
        if let view = view {
            self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -value).isActive = true
        } else {
            self.trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -value).isActive = true
        }
    }
    
    private func setTop(view: UIView?, value: CGFloat) {
        if let view = view {
            self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: value).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview!.topAnchor, constant: value).isActive = true
        }
    }
    
    private func setBottom(view: UIView?, value: CGFloat) {
        if let view = view {
            self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -value).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -value).isActive = true
        }
    }
    
    private func setCenterX(view: UIView?) {
        if let view = view {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            self.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        }
    }
    
    private func setCenterY(view: UIView?) {
        if let view = view {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            self.centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        }
    }
    
    private func setLeadingToSafeArea(view: UIView?, value: CGFloat) {
       if let view = view {
           self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: value).isActive = true
       } else {
           self.leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: -value).isActive = true
       }
    }
    
    private func setTrailingToSafeArea(view: UIView?, value: CGFloat) {
        if let view = view {
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: value).isActive = true
        } else {
            self.trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -value).isActive = true
        }
    }
    
    private func setTopToSafeArea(view: UIView?, value: CGFloat) {
        if let view = view {
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: value).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: value).isActive = true
        }
    }
    
    private func setBottomToSafeArea(view: UIView?, value: CGFloat) {
        if let view = view {
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -value).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: -value).isActive = true
        }
    }
    
    
} // extenstion
