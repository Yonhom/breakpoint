//
//  MeVC.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/2.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // show the current loged in user's email address
        email.text = Auth.auth().currentUser?.email
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Sign Out", message: "Do you want to sign out the current user?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
            // the sign out action
            if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                    // the sign out is successful, show the auth page again for login or signup
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.presentViewController(withStoryboardName: "Main", andId: "AuthVC")
                } catch {
                    print("Signing out with a error: \(error.localizedDescription)")
                }
            } else {
                print("already signed out!")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
