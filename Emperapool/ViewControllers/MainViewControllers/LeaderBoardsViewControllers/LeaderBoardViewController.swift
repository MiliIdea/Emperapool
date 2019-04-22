//
//  LeaderBoardViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var tabView: UIView!
    
    @IBOutlet weak var mainBoard: UIView!
    
    @IBOutlet weak var seprator: UIView!
    
    @IBOutlet weak var tabIndicator: UIView!
    
    var tabsController : TabController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabIndicator.setY(y: self.seprator.y - self.tabIndicator.height)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Change `2.0` to the desired number of seconds.
            self.configureTopTabs()
        }
        
    }
    

    func configureTopTabs(){
        
        var tabs : [TopTab] = [TopTab]()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        ////////
        let vC0 : LeadersViewController = (storyboard.instantiateViewController(withIdentifier: "LeadersViewController")) as! LeadersViewController
        vC0.type = .overall
        let tab0 : TopTab = TopTab.init(vc: vC0 , title: "همیشه")
        tabs.append(tab0)
        
        ////////
        let vC1 : LeadersViewController = (storyboard.instantiateViewController(withIdentifier: "LeadersViewController")) as! LeadersViewController
        vC1.type = .Month
        let tab1 : TopTab = TopTab.init(vc: vC1 , title: "ماهیانه")
        tabs.append(tab1)

        
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
