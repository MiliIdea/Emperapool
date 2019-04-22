//
//  MainViewController.swift
//  Emperapool
//
//  Created by MAC on 4/10/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var mainBoard: UIView!
    
    @IBOutlet weak var tabBarView: UIView!
    
    @IBOutlet weak var titleOfTabs: UILabel!
    
    var tabsController : TabController?
    
    @IBOutlet weak var sliderView: UIView!
    
    @IBOutlet weak var slideButton: UIButton!
    
    var slideIsHide : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MR.getProfile(vc: self){res in
            print(res)
        }
        
        self.configureTabs()
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTabs(){
        
        var tabs : [Tab] = [Tab]()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        ////////
        let vC1 : AwardViewController = (storyboard.instantiateViewController(withIdentifier: "AwardViewController")) as! AwardViewController
        let tab0 : Tab = Tab.init(vc: vC1 , title: "جوایز", activeI: UIImage.init(named: "prize")!, passiveI: UIImage.init(named: "p_prize")!)
        tabs.append(tab0)
        
        /////////
        let vC2 : ProfileViewController = (storyboard.instantiateViewController(withIdentifier: "ProfileViewController")) as! ProfileViewController
        let tab1 : Tab = Tab.init(vc: vC2 , title: "پروفایل", activeI: UIImage.init(named: "profile")!, passiveI: UIImage.init(named: "p_profile")!)
        tabs.append(tab1)
        /////////
        let vC3 : StoreViewController = (storyboard.instantiateViewController(withIdentifier: "StoreViewController")) as! StoreViewController
        let tab2 : Tab = Tab.init(vc: vC3 , title: "فروشگاه", activeI: UIImage.init(named: "shop")!, passiveI: UIImage.init(named: "p_shop")!)
        tabs.append(tab2)
        /////////
        let vC4 : LeaderBoardViewController = (storyboard.instantiateViewController(withIdentifier: "LeaderBoardViewController")) as! LeaderBoardViewController
        let tab3 : Tab = Tab.init(vc: vC4 , title: "رده بندی", activeI: UIImage.init(named: "leaderboard")!, passiveI: UIImage.init(named: "p_leaderboard")!)
        tabs.append(tab3)
        /////////
        let vC5 : HomeViewController = (storyboard.instantiateViewController(withIdentifier: "HomeViewController")) as! HomeViewController
        let tab4 : Tab = Tab.init(vc: vC5 , title: "امپراپول", activeI: UIImage.init(named: "dashboard")!, passiveI: UIImage.init(named: "p_dashboard")! , isHomeTab: true)
        tabs.append(tab4)
        /////////
        
        self.tabsController = TabController.init(parentVC: self, mainBoard: self.mainBoard, tabsButtonsView: self.tabBarView, tabs: tabs)
        
        self.mainBoard.frame.origin.x = CGFloat(-1 * 4) * self.view.frame.width
        
        self.titleOfTabs.text = self.tabsController?.tabs[4].title
        
        self.tabsController?.updateButtonImages(index: 5)
        
    }
    
    @IBAction func goMenu(_ sender: Any) {
        navigate(storyboardName : "GameMenu",vc: GameMenuViewController.self){vc in }
    }
    
    @IBAction func help(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc : ProfileSettingsViewController = (storyboard.instantiateViewController(withIdentifier: "ProfileSettingsViewController")) as! ProfileSettingsViewController
        
        self.addChild(vc)
        
        vc.didMove(toParent: self)
        
        self.view.addSubview(vc.view)
    }
    
    @objc func tabPressed(sender : UIButton){
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            self.mainBoard.frame.origin.x = CGFloat(-1 * (sender.tag - 1)) * self.view.frame.width
        },completion: nil)
        self.titleOfTabs.text = self.tabsController?.tabs[sender.tag - 1].title
        self.tabsController?.updateButtonImages(index: sender.tag)
    }
    
    @IBAction func slide(_ sender: Any) {
        if(slideIsHide){
            showSlider()
        }else{
            hideSlider()
        }
    }
    
    func hideSlider(){
        slideIsHide = true
        UIView.animate(withDuration: 0.4, delay: 0 , options: .curveEaseInOut, animations: {
            self.sliderView.frame.origin.y = self.tabBarView.frame.origin.y - self.slideButton.frame.height
            self.slideButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        },completion: nil)
        
    }
    
    func showSlider(){
        slideIsHide = false
        UIView.animate(withDuration: 0.4, delay: 0 , options: .curveEaseInOut, animations: {
            self.sliderView.frame.origin.y = self.tabBarView.frame.origin.y - self.sliderView.frame.height
            self.slideButton.transform = CGAffineTransform(rotationAngle: (2 * CGFloat.pi))
        },completion: nil)
    }
    
    
}
