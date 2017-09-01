//
//  LoginField.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit

class LoginField: UITextField {

    override func awakeFromNib() {
        
        // set the left&right view
        leftView = UIView()
        rightView = UIView()
        // make sure that those overlay view above is always displayed
        rightViewMode = .always
        leftViewMode = .always
        
        guard let ph = placeholder else {return}
        
        // set the placeholder text's color to be white
        attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        super.awakeFromNib()
    }
    
    // those overroden method will return the rect for the overlay view specified above
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y,
                      width: 10, height: bounds.size.height)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.size.width - 10, y: bounds.origin.y,
                      width: 10, height: bounds.size.height)
    }
    
    
    
    
    

}

