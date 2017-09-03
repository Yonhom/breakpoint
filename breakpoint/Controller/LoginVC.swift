//
//  LoginVC.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: LoginField!
    
    @IBOutlet weak var passwordField: LoginField!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text { // email & password is not nil
            // when the login is pressed, show the progress indicator
            isInProgress(inProgress: true)
            AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (success, error) in
                if success {
                    
                    self.isInProgress(inProgress: false)
                    print("login first attempt successed!")
                    // login successed, dismiss both auth and login vc
                    self.dismissLoginAndAuthVC()
                    
                } else {
                    self.isInProgress(inProgress: true)
                    print("login first attempt failed, now trying to signing up...")
                    AuthService.instance.registerUser(withEmail: email, andPassword: password, completion: { (success, error) in
                        if success {
                            
                            self.isInProgress(inProgress: true)
                            print("trying to login for the second time...")
                            
                            AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (success, error) in
                                if success {
                                    self.isInProgress(inProgress: false)
                                    print("login second attempt successed!")
                                    // dismiss auth and login vc
                                    self.dismissLoginAndAuthVC()
                                } else {
                                    self.isInProgress(inProgress: false)
                                    print("login second attempt failed!")
                                    self.loginBtn.shakeSelf()
                                }
                            })
                        } else {
                            self.isInProgress(inProgress: false)
                            print("signing up failed with log: \(error.debugDescription)")
                            // shake the 'login' button
                            self.loginBtn.shakeSelf()
                        }
                    })
                }
            })
            
        } else {
            print("Login failed! Please check your acount again!")
            loginBtn.shakeSelf()
        }
        
    }
    
    func dismissLoginAndAuthVC() {
        // capture the presentingViewController's reference, so after the first vc is popped off
        // and destroyed, the presentingVC can still be refered to pop itself off
        let presentingVC = presentingViewController
        dismiss(animated: true, completion: {
            presentingVC?.dismiss(animated: true, completion: nil)
        })
    }
    
    /**
     * is login or signup in progrees?
     */
    func isInProgress(inProgress: Bool) {
        if inProgress {
            progressIndicator.isHidden = false
            loginBtn.isEnabled = false
        } else {
            progressIndicator.isHidden = true
            loginBtn.isEnabled = true
        }
    }
    
}
