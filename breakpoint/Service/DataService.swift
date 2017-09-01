//
//  DataService.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import Foundation
import FirebaseDatabase

// get a reference to the Firebase's database for the app
let DB_BASE = Database.database().reference()

/**
 * get reference to the app's firebase db for the database itself and the
 entry inside it for reading or writing data from/to it
 */
class DataService {
    static let instance = DataService()  // sinpleton DataService
    
    private var _REF_BASE = DB_BASE
    // get the users entry in the database if there is any. If not, create one and return the reference
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_FEED
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_GROUPS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        // add user data to 'users' table with a unique identifier
        REF_USERS.child(uid).updateChildValues(userData)
    }
}














