//
//  GameToturialViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class GameToturialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        self.back(self)
    }
    
    @IBAction func goVideo(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/help/"
        let myTitle : String = "چطوری بازی کنیم؟"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }
    
    @IBAction func home(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/home/"
        let myTitle : String = "آموزش قسمت خانه"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }
    
    @IBAction func game(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/game/"
        let myTitle : String = "آموزش قسمت خانه"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }
    
    @IBAction func leaderboard(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/ranking/"
        let myTitle : String = "آموزش قسمت خانه"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }
    
    @IBAction func shop(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/shop/"
        let myTitle : String = "آموزش قسمت خانه"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }
    
    @IBAction func prize(_ sender: Any) {
        let myUrl : String = "panel.emperapool.com/static/prize/"
        let myTitle : String = "آموزش قسمت خانه"
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.urlToLoad = myUrl
            vc.myTitle = myTitle
        }
    }

}
