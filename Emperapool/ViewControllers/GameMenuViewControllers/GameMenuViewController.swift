//
//  GameMenuViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.back(self)
    }
    
    
    @IBAction func goSupport(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: SupportViewController.self){_ in}
    }
    
    @IBAction func goMessages(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: MessagesViewController.self){_ in}
    }
    
    @IBAction func goCreateQuestion(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: CreateQuestionViewController.self){_ in}
    }
    
    @IBAction func goNews(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: NewsViewController.self){_ in}
    }
    
    @IBAction func goSettings(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: GameSettingsViewController.self){_ in}
    }
    
    @IBAction func goGameTutorial(_ sender: Any) {
        navigate(storyboardName: "GameMenu", vc: GameToturialViewController.self){_ in}
    }
    
    @IBAction func goRateUs(_ sender: Any) {
        self.view.makeToast("rate us")
    }
    
    @IBAction func goTerms(_ sender: Any) {
        self.view.makeToast("terms")
    }
    
    @IBAction func goContactUs(_ sender: Any) {
        self.view.makeToast("contact us")
    }
    
    
    @IBAction func logout(_ sender: Any) {
        App.defaults.removeObject(forKey: DefaultStrings.token)
        let storyboard = UIStoryboard(name: "OTP", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: secondViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        navigationController.setNavigationBarHidden(true, animated: false)
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.rootViewController = navigationController
    }
    
}
