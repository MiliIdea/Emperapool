//
//  InviteFriendsViewController.swift
//  Emperapool
//
//  Created by MAC on 4/23/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController {

    
    @IBOutlet weak var introduceCode: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    
    @IBOutlet weak var shareCoinLabel: UILabel!
    @IBOutlet weak var shareGemLabel: UILabel!
    @IBOutlet weak var instaCoinLabel: UILabel!
    @IBOutlet weak var instaGemLabel: UILabel!
    
    var shareText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shareButton.imageView?.contentMode = .scaleAspectFit
        self.instaButton.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func copyIntroduceCode(_ sender: Any) {
    }
    
    @IBAction func share(_ sender: Any) {
    }
    
    @IBAction func shareInsta(_ sender: Any) {
    }
    
}
