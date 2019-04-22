//
//  CoinCollectionViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/18/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit

class CoinCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    
    @IBOutlet weak var coinAmount: UILabel!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var topBackgroundView: DCBorderedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
