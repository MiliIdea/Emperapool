//
//  SplashViewController.swift
//  Emperapool
//
//  Created by MAC on 4/17/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "emp_studio")
        
        animationView.frame.size = lottieView.frame.size
        
        animationView.frame.origin = .init(x: 0, y: 0)
        
        animationView.contentMode = UIView.ContentMode.scaleAspectFit
        
        animationView.alpha = 1
        
        lottieView.addSubview(animationView)
        
        animationView.play() { (finished) in
            self.goToSpecificViewController()
            self.lottieView.alpha = 0
            animationView.stop()
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    

    func goToSpecificViewController(){
        if(App.defaults.object(forKey: DefaultStrings.token) != nil){
            navigate(vc: MainViewController.self){_ in}
        }else{
            navigate(storyboardName: "OTP", vc: LoginViewController.self){_ in}
        }
    }

}
