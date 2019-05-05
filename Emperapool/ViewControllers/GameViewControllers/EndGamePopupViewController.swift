//
//  EndGamePopupViewController.swift
//  Emperapool
//
//  Created by MAC on 5/5/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class EndGamePopupViewController: UIViewController {

    
    var scoreCalculator : ScoreCalculatorInQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resume(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func exit(_ sender: Any) {
        
        if(((self.parent as! GameBoardViewController).xmpp?.xmppStream.isConnected) ?? false){
            (self.parent as! GameBoardViewController).xmpp?.xmppStream.disconnect()
        }
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        
        let vc : LoserPopupViewController = (storyboard.instantiateViewController(withIdentifier: "LoserPopupViewController")) as! LoserPopupViewController
        
        vc.scoreCalculator = self.scoreCalculator
        
        self.parent!.addChild(vc)
        
        vc.didMove(toParent: self.parent!)
        
        self.parent!.view.addSubview(vc.view)
        
        self.view.removeFromSuperview()
        
        self.removeFromParent()
    }
   

}
