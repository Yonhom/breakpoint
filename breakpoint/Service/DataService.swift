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
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    /**
     once a user is signed up, store it in the database
     */
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        // add user data to 'users' table with a unique identifier
        // when you create a user with firebase auth, a user uid is created for you
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    /**
     * post a message with a user id and groupkey(optional)
     */
    func postMessage(_ message: String, forUid uid: String, ofGroup groupKey: String?, completion: @escaping (_ status: Bool) -> ()) {
        
        if groupKey == nil {
            // post the message in public
            REF_FEED.childByAutoId().updateChildValues(["message": message, "senderId": uid], withCompletionBlock: { (error, dataRef) in
                guard let error = error else {
                    // update message successed, fire up the outer closure to notify success info
                    completion(true)
                    return
                }
                print("A error appeared posting message: \(error.localizedDescription)")
                completion(false)
            })
        } else {
            // post it into groups
        }
        
    }
    
    // retrieve all message from the feeds table
    func retrieveAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) -> UInt {
//        var messageArray = [Message]()
        // this event is triggered only once
//        REF_FEED.observeSingleEvent(of: .value) { (dataShot) in
//            guard let dataShot = dataShot.children.allObjects as? [DataSnapshot] else {
//                print("Message retrieving has occured a problem, please try again!")
//                return
//            }
//
//            for message in dataShot {
//                let content = message.childSnapshot(forPath: "message").value as! String
//                let senderId = message.childSnapshot(forPath: "senderId").value as! String
//                let message = Message(content: content, senderId: senderId)
//                messageArray.append(message)
//            }
//
//            handler(messageArray)
//        }
        
        /**
         * this handle will be returned by oberve feed value changes, and
         is used to remove the observer later
         */
        var feedBlockHandle: UInt!
        
        // this event is triggered as long as the observed data is changed
        feedBlockHandle = REF_FEED.observe(.value) { (dataShot) in
            guard let dataShot = dataShot.children.allObjects as? [DataSnapshot] else {
                print("Message retrieving has occured a problem, please try again!")
                return
            }
            
            var tempMessageArr = [Message]()
            
            for message in dataShot {
                let content = message.childSnapshot(forPath: "message").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                let message = Message(content: content, senderId: senderId)
                tempMessageArr.append(message)
            }
            
            handler(tempMessageArr.reversed())
        }
        
        return feedBlockHandle
    }
    
    /**
     * retrive a user's email address using uid
     */
    func getUsername(forUid uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (dataShot) in
            guard let dataShot = dataShot.children.allObjects as? [DataSnapshot] else{return}
            for user in dataShot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    
}














