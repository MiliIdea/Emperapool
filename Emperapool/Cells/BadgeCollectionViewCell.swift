//
//  BadgeCollectionViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/18/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit

class BadgeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var badgeTitle: UILabel!
    
    @IBOutlet weak var back: DCBorderedView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var backCoin: DCBorderedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
