//
//  AvatarCollectionViewCell.swift
//  Emperapool
//
//  Created by MAC on 4/18/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit
import CheckboxButton

class AvatarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: DCBorderedView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var coinBackView: DCBorderedView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var checkBox: CheckboxButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
