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
    
    var topTabs : [TopTab] = [TopTab]()
    
    var mainBoard : UIView
    
    var tabsButtonsView : UIView
    
    var parentVC : UIViewController

    init(parentVC : UIViewController , mainBoard : UIView , tabsButtonsView : UIView , tabs : [Tab]) {
        self.mainBoard = mainBoard
        self.tabsButtonsView = tabsButtonsView
        self.tabs = tabs
        self.parentVC = parentVC
        self.setupTabViews()
    }
    
    init(parentVC : UIViewController , mainBoard : UIView , tabsButtonsView : UIView , topTabs : [TopTab]) {
        self.mainBoard = mainBoard
        self.tabsButtonsView = tabsButtonsView
        self.topTabs = topTabs
        self.parentVC = parentVC
        self.setupTopTabViews()
    }
    
    func setupTabViews(){
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
    
    
    func setupTopTabViews(){
        self.mainBoard.frame.size.width = (self.parentVC.view.frame.width * CGFloat(self.topTabs.count))
        let w = self.parentVC.view.frame.width
        let tBW = self.tabsButtonsView.frame.width / CGFloat(self.topTabs.count)
        let tBH = self.tabsButtonsView.frame.height 
        var index = 0
        for t in self.topTabs {
            //adding tabs view controller
            let v = UIView.init(frame: CGRect.init(x: CGFloat(index) * w , y: 0, width: w, height: self.mainBoard.frame.height))
            self.mainBoard.addSubview(v)
            self.parentVC.add(t.viewController, containerView: v)
            //adding buttons
            let b = UIButton.init(frame: .init(x: CGFloat(index) * tBW, y: 0, width: tBW , height: tBH))
            b.contentMode = .scaleAspectFit
            b.tag = index + 1
            b.setTitle(t.title, for: .normal)
            b.titleLabel?.font = UIFont.init(name: "SHABNAM-BOLD-FD", size: 17)
            b.addTarget(self.parentVC, action: #selector(StoreViewController.tabPressed(sender:)), for: .touchUpInside)
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
   
    func updateButtonsBackground(index : Int){
        for i in 1...(self.topTabs.count) {
            (self.tabsButtonsView.viewWithTag(i) as! UIButton).backgroundColor = UIColor.init(white: 1, alpha: 0)
        }
        (self.tabsButtonsView.viewWithTag(index) as! UIButton).backgroundColor = UIColor.init(white: 1, alpha: 0.2)
    }
    
    
}

public struct TopTab {
    init(vc : UIViewController , title : String) {
        self.viewController = vc
        self.title = title
    }
    var viewController : UIViewController
    var title : String
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
