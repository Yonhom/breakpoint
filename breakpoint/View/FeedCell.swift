//
//  FeedCell.swift
//  breakpoint
//
//  Created by 徐永宏 on 2017/9/2.
//  Copyright © 2017年 徐永宏. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        username.text = message.senderId
        self.message.text = message.content
    }
    
    func configureCell(withEmail email: String, withMessage message: String) {
        username.text = email
        self.message.text = message
    }

}
