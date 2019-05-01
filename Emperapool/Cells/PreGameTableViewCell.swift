//
//  PreGameTableViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/29/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class PreGameTableViewCell: UITableViewCell {

    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var coinBox: UIView!
    @IBOutlet weak var gemBox: UIView!
    @IBOutlet weak var badgeBox: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var gemLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
