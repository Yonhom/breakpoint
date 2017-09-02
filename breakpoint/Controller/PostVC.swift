//
//  PostVC.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/2.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    private let MESSAGE_PLACEHOLDER = "Say something here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postView.delegate = self
        sendBtn.followKeyboard() // to make the send btn to follow the keyboard
    }

    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        let msg = postView.text!
        if msg == "" || msg == MESSAGE_PLACEHOLDER {
            print("Please say something first...")
            return
        } else {
            sendBtn.isEnabled = false
            DataService.instance.postMessage(msg, forUid: (Auth.auth().currentUser?.uid)!, ofGroup: nil, completion: { (status) in
                self.sendBtn.isEnabled = true
                if status {
                    print("posting message successeded!")
                } else {
                    print("posting message failed!")
                }
            })
        }
    }
}

extension PostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // this delegate method called means the editing is just started
        // we should clear the placeholder text first
        postView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if postView.text == "" {
            postView.text = MESSAGE_PLACEHOLDER
        }
    }
}
