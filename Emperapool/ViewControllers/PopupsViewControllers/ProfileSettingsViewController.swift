//
//  ProfileSettingsViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    
    @IBOutlet weak var popupBackView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        
        self.popupBackView.frame.origin.y = self.view.frame.height
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
            
            self.popupBackView.frame.origin.y = 0
            
        },completion: nil)
        
    }
    

    @IBAction func accept(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupBackView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @IBAction func deny(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupBackView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
    }
    
}
