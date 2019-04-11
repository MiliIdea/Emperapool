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
        MR.approveToken(vc: self, phone: self.phoneNumber.text ?? "", activationCode: codeTextField.text ?? ""){res in
            if let token = res?.extra_data?.token {
                App.defaults.set(token, forKey: DefaultStrings.token)
                self.navigate(vc: MainViewController.self){_ in}
            }
        }
    }
    
    @IBAction func resendCode(_ sender: Any) {
        MR.register(vc: self, phone: self.phoneNumber.text!){ res in
             self.view.makeToast("code generated")
        }
    }
    
}
