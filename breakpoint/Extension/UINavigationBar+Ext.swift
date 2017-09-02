//
//  UINavigationBar+Ext.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/2.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit

var attachTop = true

extension UINavigationBar: UINavigationBarDelegate {
    
    // this is called a stored property, extension cant have it
//    var isTopAttached: Bool = true {
//        didSet {
//
//        }
//    }
    
    open override func awakeFromNib() {
        delegate = self
        super.awakeFromNib()
    }
    
    
    // this is a getter and setter, getter and setter need another variable to hold the value
    @IBInspectable
    var isTopAttached: Bool {
        set {
            attachTop = newValue
        }
        get {
            return attachTop
        }
    }
    
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        // set the navigation bar top attachment style according to the attachTop boolean value
        if attachTop {
            return .topAttached
        } else {
            return .any
        }
    }
    
}
