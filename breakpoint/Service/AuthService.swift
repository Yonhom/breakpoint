//
//  AuthService.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import Firebase

class AuthService {
    
    static var instance = AuthService()
    
    // escapong means the closure will be called after the function is returned
    func registerUser(withEmail email: String, andPassword password: String,
                      completion: @escaping (Bool, Error?) -> ()) {
        
        // register user using firebase, if successsed, login directly
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(false, error) // user not registered with a error info from firebase
                return
            }
            // create user successed, store in firebase database
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            completion(true, nil) // user registeration successeded with no error
        }
        
    }
    
    func loginUser(withEmail email: String, andPassword password: String,
                   completion: @escaping (Bool, Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user  else {
                completion(false, error)
                return
            }
            // sign in successeded with no error
            completion(true, nil)
        }
    }
    
}
