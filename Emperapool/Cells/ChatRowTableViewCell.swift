//
//  ChatRowTableViewCell.swift
//  Emperapool
//
//  Created by MAC on 5/1/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class ChatRowTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var nameWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
