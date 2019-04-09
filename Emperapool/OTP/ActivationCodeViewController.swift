//
//  ActivationCodeViewController.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class ActivationCodeViewController: UIViewController {

    
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    var phone : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupVC()
        
        self.phoneNumber.text = phone
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        back(self)
    }
    
    @IBAction func entry(_ sender: Any) {
        
    }
    
    @IBAction func resendCode(_ sender: Any) {
        
    }
    
}
