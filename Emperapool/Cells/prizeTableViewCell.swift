//
//  prizeTableViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/18/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class prizeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var prizeTitle: UILabel!
    
    @IBOutlet weak var prizeIcon: UIImageView!
    
    @IBOutlet weak var gemCost: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buy(_ sender: Any) {
    }
    
}
