//
//  ShadowView.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        
        // configure the view layer's shadow
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.black.cgColor
        
        super.awakeFromNib()
    }

}
