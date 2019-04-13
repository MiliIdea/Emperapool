//
//  MainViewController.swift
//  Emperapool
//
//  Created by MAC on 4/10/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MR.getProfile(vc: self){res in
            print(res)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goMenu(_ sender: Any) {
        navigate(storyboardName : "GameMenu",vc: GameMenuViewController.self){vc in
            
        }
    }
    
    
}
