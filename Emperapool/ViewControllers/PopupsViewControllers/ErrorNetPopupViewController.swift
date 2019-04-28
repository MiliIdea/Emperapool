//
//  ErrorNetPopupViewController.swift
//  Emperapool
//
//  Created by MAC on 4/23/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Lottie

class ErrorNetPopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var lottieView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popupView.frame.origin.y = self.view.frame.height
        
        let animationView = AnimationView(name: "networkError")
        
        animationView.frame.size = lottieView.frame.size
        
        animationView.frame.origin = .init(x: 0, y: 0)
        
        animationView.contentMode = UIView.ContentMode.scaleAspectFit
        
        animationView.alpha = 1
        
        lottieView.addSubview(animationView)
        
        animationView.loopMode = .loop
        
        animationView.play()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runPopup()
    }
    
    @IBAction func retry(_ sender: Any) {
        self.dissmissView()
    }
    
    

    func dissmissView(){
        UIView.animate(withDuration: 0.5, delay: 0 , options: .curveEaseInOut, animations: {
            self.popupView.frame.origin.y = self.view.frame.height
        }){ completion in
            App.dismissLoading(vc: self.parent!)
            if(self.parent != nil && self.parent!.view.viewWithTag(909) != nil){
                self.parent!.view.viewWithTag(909)?.removeFromSuperview()
            }
            self.parent?.viewDidLoad()
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    func runPopup(){
        UIView.animate(withDuration: 0.5, delay: 0.0 , options: .curveEaseInOut, animations: {
            self.popupView.frame.origin.y = 0
        },completion : nil)
    }
    

}
