//
//  ProfileDatePickerViewController.swift
//  Emperapool
//
//  Created by MAC on 5/7/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import PersianDatePicker

class ProfileDatePickerViewController: UIViewController {

    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picker: PersianDatePickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.onChange = { (year, month, day) in
            self.dateLabel.text = "\(year)/\(month)/\(day)"
        }
        
        picker.setPersianDate(year: 1370, month: 1, day: 1)
    }
    

    @IBAction func ok(_ sender: Any) {
        (self.parent as! ProfileSettingsViewController).BDTxtField.text = self.dateLabel.text
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    

}
