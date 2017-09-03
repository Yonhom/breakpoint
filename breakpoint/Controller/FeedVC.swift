//
//  FirstViewController.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/1.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var messageTable: UITableView!
    
    var feedMessages = [Message]()
    
    /**
     handle for removing the observer from firebase
     */
    var feedObserverHandle: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.delegate = self
        messageTable.dataSource = self
        
        feedObserverHandle = DataService.instance.retrieveAllFeedMessages { (messages) in
            self.feedMessages = messages
            self.messageTable.reloadData()
        }
        
    }
    
    

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell {
            let message = feedMessages[indexPath.row]
            DataService.instance.getUsername(forUid: message.senderId, handler: { (email) in
                cell.configureCell(withEmail: email, withMessage: message.content)
            })
            return cell
        }
        
        return UITableViewCell()
        
    }
}


