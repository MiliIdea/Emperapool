//
//  TabController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit

public class TabController {

    var tabs : [Tab] = [Tab]()
    
    var mainBoard : UIView
    
    var tabsButtonsView : UIView
    
    var parentVC : UIViewController

    init(parentVC : UIViewController , mainBoard : UIView , tabsButtonsView : UIView , tabs : [Tab]) {
        self.mainBoard = mainBoard
        self.tabsButtonsView = tabsButtonsView
        self.tabs = tabs
        self.parentVC = parentVC
        self.setupViews()
    }
    
    func setupViews(){
        self.mainBoard.frame.size.width = (self.parentVC.view.frame.width * CGFloat(self.tabs.count))
        let w = self.parentVC.view.frame.width
        let tBW = self.tabsButtonsView.frame.width / CGFloat(self.tabs.count)
        let tBH = self.tabsButtonsView.frame.height
        var index = 0
        for t in self.tabs {
            //adding tabs view controller
            let v = UIView.init(frame: CGRect.init(x: CGFloat(index) * w , y: 0, width: w, height: self.mainBoard.frame.height))
            self.mainBoard.addSubview(v)
            self.parentVC.add(t.viewController, containerView: v)
            //adding buttons
            let b = UIButton.init(frame: .init(x: CGFloat(index) * tBW, y: 0, width: tBW , height: tBH))
            b.setImage(t.passiveImage, for: .normal)
            b.contentMode = .scaleAspectFit
            b.imageView?.contentMode = .scaleAspectFit
            b.tag = index + 1
            b.addTarget(self.parentVC, action: #selector(MainViewController.tabPressed(sender:)), for: .touchUpInside)
            self.tabsButtonsView.addSubview(b)
            index += 1
        }
    }
    
    func updateButtonImages(index : Int){
        for i in 1...(self.tabs.count) {
            (self.tabsButtonsView.viewWithTag(i) as! UIButton).setImage(self.tabs[i - 1].passiveImage, for: .normal)
        }
        (self.tabsButtonsView.viewWithTag(index) as! UIButton).setImage(self.tabs[index - 1].activeImage, for: .normal)
    }
   
    
    
}

public struct Tab {
    init(vc : UIViewController , title : String ,activeI : UIImage , passiveI : UIImage , isHomeTab : Bool = false) {
        self.viewController = vc
        self.activeImage = activeI
        self.passiveImage = passiveI
        self.title = title
        self.isHomeTab = isHomeTab
    }
    var viewController : UIViewController
    var activeImage : UIImage
    var passiveImage : UIImage
    var title : String
    var isHomeTab : Bool
}
