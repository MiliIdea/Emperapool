//
//  StoreViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var tabView: UIView!
    
    @IBOutlet weak var mainBoard: UIView!
    
    @IBOutlet weak var seprator: UIView!
    
    @IBOutlet weak var tabIndicator: UIView!
    
    var tabsController : TabController?
    
    var shopListResponse : ShopListRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabIndicator.setY(y: self.seprator.y - self.tabIndicator.height)
        App.showLoading(vc: self)
        MR.getShopList(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil){
                self.shopListResponse = res?.data
                self.configureTopTabs()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func configureTopTabs(){
        
        var tabs : [TopTab] = [TopTab]()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        ////////
        let vC0 : CoinStoreViewController = (storyboard.instantiateViewController(withIdentifier: "CoinStoreViewController")) as! CoinStoreViewController
        let tab0 : TopTab = TopTab.init(vc: vC0 , title: "سکه")
        tabs.append(tab0)
        
        ////////
        let vC1 : AvatarStoreViewController = (storyboard.instantiateViewController(withIdentifier: "AvatarStoreViewController")) as! AvatarStoreViewController
        let tab1 : TopTab = TopTab.init(vc: vC1 , title: "آواتار")
        tabs.append(tab1)
        
        ////////
        let vC2 : BadgeStoreViewController = (storyboard.instantiateViewController(withIdentifier: "BadgeStoreViewController")) as! BadgeStoreViewController
        let tab2 : TopTab = TopTab.init(vc: vC2 , title: "نشان")
        tabs.append(tab2)
        
        self.tabsController = TabController.init(parentVC: self, mainBoard: self.mainBoard, tabsButtonsView: self.tabView, topTabs: tabs)
        
        self.tabIndicator.setWidth(width: self.tabView.width / CGFloat(self.tabsController!.topTabs.count))
        
        self.mainBoard.frame.origin.x = CGFloat(-1 * (1 - 1)) * self.view.frame.width

        self.tabIndicator.setX(x: CGFloat((1 - 1)) * self.tabIndicator.width )

        self.tabsController?.updateButtonsBackground(index: 1)
    }
    
    
    @objc func tabPressed(sender : UIButton){
        sender.frame.size.height = self.tabView.height
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            self.mainBoard.frame.origin.x = CGFloat(-1 * (sender.tag - 1)) * self.view.frame.width
            self.tabIndicator.setX(x: CGFloat((sender.tag - 1)) * self.tabIndicator.width )
        },completion: nil)
        self.tabsController?.updateButtonsBackground(index: sender.tag)
        
    }
}
