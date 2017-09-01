//
//  AppDelegate.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /**
     * app instance will call this method after finishing launching
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // if there isnt a current user, go to the auth page
        if Auth.auth().currentUser == nil {
            // get the authVC ref
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AuthVC")
            
            // present the authVC
            window?.makeKeyAndVisible()
            window?.rootViewController?.present(vc, animated: true, completion: nil)
        } else {
            print("Already has a user: \(Auth.auth().currentUser.debugDescription)")
        }
        
        return true
    }


}

