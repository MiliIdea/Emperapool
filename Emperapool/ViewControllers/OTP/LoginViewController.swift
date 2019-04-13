//
//  ViewController.swift
//  Emperapool
//
//  Created by MAC on 4/8/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {

    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var mobileViewHolder: DCBorderedView!
    
    @IBOutlet weak var sendMobileNumberButton: DCBorderedButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupVC()
        
        self.mobileViewHolder.cornerRadius = self.mobileViewHolder.frame.height / 2
        
        self.mobileTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }

    @IBAction func sendMobileNumber(_ sender: Any) {
        MR.register(vc: self, phone: self.mobileTextField.text!){ res in
            self.navigate(storyboardName : "OTP",vc: ActivationCodeViewController.self){v in
                v.phone = self.mobileTextField.text ?? ""
            }
        }
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(self.mobileTextField.text?.count == 11){
            self.view.endEditing(true)
        }
        if((self.mobileTextField.text?.count)! > 11){
            self.mobileTextField.text?.removeLast()
        }
    }
    
    func isValidPhone(testStr:String) -> Bool {
        let testStr2 = convertToEng(inputStr: testStr)
        let phoneRegEx = "09+[0-9۰-۹]{0,9}"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: testStr2)
    }
    
    func convertToEng(inputStr:String)-> String {
        let numbersDictionary : Dictionary = ["۰" : "0","۱" : "1", "۲" : "2", "۳" : "3", "۴" : "4", "۵" : "5", "۶" : "6", "۷" : "7", "۸" : "8", "۹" : "9"]
        var str : String = inputStr
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
    
}

