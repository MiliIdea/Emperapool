//
//  Extentions.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupVC(){
        self.hideKeyboardWhenTappedAround()
        IQKeyboardManager.shared.enable = true
    }
    
    func previousViewController() -> UIViewController?{
        guard let counter = (self.navigationController?.viewControllers.count) else {
            return nil
        }
        return self.navigationController?.viewControllers[counter - 2]
    }
    
    func navigate<T : UIViewController>(storyboardName : String = "Main" , vc : T.Type, completionHandler: @escaping (T) -> Void){
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vC : T = (storyboard.instantiateViewController(withIdentifier: String(vc.description().split(separator: ".")[1]))) as! T
        completionHandler(vC)
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func back(_ vc : UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
