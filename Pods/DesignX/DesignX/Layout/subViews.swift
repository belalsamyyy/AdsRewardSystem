//
//  nested.swift
//  APIManager
//
//  Created by Belal Samy on 27/08/2021.
//

import Foundation
import UIKit


//MARK: - SubViewController
extension UIViewController {
    //Func - addSubViewController
    public func addSubViewController(_ viewController: UIViewController, inside: UIView) {
        inside.addSubview(viewController.view)
        self.addChild(viewController)
    }
    
    //Func - removeViewController
    public func removeSubViewController(_ viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}

//MARK: - Subviews
public extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

