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
    
    
    func add(_ child: UIViewController , containerView : UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame.size = containerView.frame.size
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    
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


extension UIView {
    
    /**
     :returns: Current view width
     */
    var width: CGFloat {
        return self.frame.size.width
    }
    
    /**
     :returns: Current view height
     */
    var height: CGFloat {
        return self.frame.size.height
    }
    
    /**
     :returns: Current view x position
     */
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    /**
     :returns: Current view y position
     */
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    /**
     :returns: Current view center x position
     */
    var centerX: CGFloat {
        return self.center.x
    }
    
    /**
     :returns: Current view center y position
     */
    var centerY: CGFloat {
        return self.center.y
    }
    
    var rightX: CGFloat {
        return self.x + self.width
    }
    
    var bottomY: CGFloat {
        return self.y + self.height
    }
    // MARK: Easily update frames parameters
    
    
    func setRight(right: CGFloat) {
        self.frame.origin.x = right - self.width
    }
    
    func setBottom(bottom: CGFloat) {
        self.frame.origin.y = bottom - self.height
    }
    
    /**
     Update frames width with a given value
     */
    func setWidth(width: CGFloat) {
        self.frame.size.width = width
    }
    
    /**
     Update frames height with a given value
     */
    func setHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    /**
     Update frames origin x with a given value
     */
    func setX(x: CGFloat) {
        self.frame.origin.x = x
    }
    
    /**
     Update frames origin y with a given value
     */
    func setY(y: CGFloat) {
        self.frame.origin.y = y
    }
    
    /**
     Update frames center x with a given value
     */
    func setCenterX(x: CGFloat) {
        self.center.x = x
    }
    
    /**
     Update frames center y with a given value
     */
    func setCenterY(y: CGFloat) {
        self.center.y = y
    }
    
}
