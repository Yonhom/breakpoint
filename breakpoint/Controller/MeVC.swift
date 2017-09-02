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

    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch {
                print("Signing out with a error: \(error.localizedDescription)")
            }
        } else {
            print("already signed out!")
        }
    }
    
}
