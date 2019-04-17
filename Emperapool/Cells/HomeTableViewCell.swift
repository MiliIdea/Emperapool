//
//  HomeTableViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backOfCell: DCBorderedView!
    @IBOutlet weak var cellsIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var prizeConditionLabel: UILabel!
    @IBOutlet weak var gemRequiredLabel: UILabel!
    @IBOutlet weak var gemRequiredback: UIView!
    @IBOutlet weak var gemRequiredBackOfLabel: DCBorderedView!
    @IBOutlet weak var coinRequiredLabel: UILabel!
    @IBOutlet weak var coinRequiredBack: UIView!
    @IBOutlet weak var coinRequiredBackOfLabel: DCBorderedView!
    
    @IBOutlet weak var coinAwardLabel: UILabel!
    @IBOutlet weak var gemAwardLabel: UILabel!
    @IBOutlet weak var coinAwardView: UIView!
    @IBOutlet weak var gemAwardView: UIView!
    
    @IBOutlet weak var requiredBox: DCBorderedView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//repeat : b ezaye har n period enqad jayeze
//once : jayeze dar soale period enqad jayeze
//xmpp chat
