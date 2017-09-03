//
//  UIView+Ext.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/2.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: view following the keyboard
    /**
     call this method to make the receiver to follow the keyboard on the y axis
     */
    func followKeyboard() {
        // register a keyboardWillChange notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    /**
     @params notification has all the info about the keyboard's animation duration, frame etc
     */
    @objc func keyboardFrameChanged(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            print(userInfo)
            
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
//            let keyboardStartFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
            let keyboardEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
//            let deltaY = keyboardEndFrame.origin.y - keyboardStartFrame.origin.y
            
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.init(rawValue: curve)], animations: {
                // animate the view's frame
                self.frame = CGRect(
                    x: self.frame.origin.x,
                    y: keyboardEndFrame.origin.y - self.frame.size.height,
                    width: self.frame.size.width,
                    height: self.frame.size.height)
                
            }, completion: nil)
        }
    }
    
    // MARK: view shaking self
    /**
     any view can call this method to shake itself as a error visual heads-up
     */
    func shakeSelf() {
        UIView.animate(withDuration: 0.1) {
            UIView.setAnimationRepeatCount(5)
            self.frame.origin.x += 5
            self.frame.origin.x -= 10
            self.frame.origin.x += 5
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
