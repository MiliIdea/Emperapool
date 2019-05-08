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


extension String {
    func convertEngNumToPersianNum()->String{
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        let number =   format.number(from: self)
        
        let faNumber = format.string(from: number!)
        return faNumber!
        
    }
    func convertToPersian()-> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}


struct AppFontName {
    static let regular = "B Yekan+"
    static let bold = "B Yekan+"
    static let italic = "B Yekan+"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}



extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
