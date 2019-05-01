//
//  QuestionViewController.swift
//  Emperapool
//
//  Created by MAC on 4/29/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Lottie
import DCKit
import UICircularProgressRing

class QuestionViewController: UIViewController {
    

    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var questionView: DCBorderedView!
    @IBOutlet weak var isOfflineButton: DCBorderedButton!
    @IBOutlet weak var onlineCount: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var gem: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var timerView: UICircularTimerRing!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstAnswer: DCBorderedButton!
    @IBOutlet weak var secondAnswer: DCBorderedButton!
    @IBOutlet weak var thirdAnswer: DCBorderedButton!
    
    @IBOutlet weak var questionAuthor: UILabel!
    
    
    @IBOutlet weak var fiftyPercentAmount: DCBaseLabel!
    @IBOutlet weak var fiftyPercentCoin: UILabel!
    
    @IBOutlet weak var timePlusAmount: DCBaseLabel!
    @IBOutlet weak var timePlusCoin: UILabel!
    
    @IBOutlet weak var percentageAmount: DCBaseLabel!
    @IBOutlet weak var percentageCoin: UILabel!
    
    
    var animationView : AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.questionView.setX(x: -1 * self.questionView.width)

        self.timerView.layer.cornerRadius = self.timerView.width / 2
        
        self.timerView.backgroundColor = .white
        
        self.timerView.valueFormatter = UICircularProgressRingFormatter.init(valueIndicator: "", rightToLeft: true, showFloatingPoint: false, decimalPlaces: 2)
        
        self.timerView.innerCapStyle = .round
        
        self.timerView.backgroundColor = .clear
        
        self.timerView.font = UIFont.init(name: "Shabnam-FD", size: 23)!

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.setLottie(name: "startgamepage")
    }
    
    @IBAction func close(_ sender: Any) {
        self.parent!.navigationController?.popViewController(animated: true)
    }
    
    
    func previewQuestion(question : Question){
        self.questionLabel.text = question.question
        self.firstAnswer.setTitle(question.option_1, for: .normal)
        self.secondAnswer.setTitle(question.option_2, for: .normal)
        self.thirdAnswer.setTitle(question.option_3, for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 0
            self.questionView.setCenterX(x: self.view.centerX)
        }){completion in }
        self.timerView.startTimer(to: 10) { state in
                switch state {
                case .finished:
                    print("finished")
                    UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                        self.lottieView.alpha = 1
                        self.setLottie(name: "middlegame")
                        self.questionView.setX(x: self.view.width)
                    }){completion in
                        self.timerView.resetTimer()
                        self.questionView.setX(x: -1 * self.view.width)
                    }
                case .continued(let time):
                    print("continued: \(time ?? 0)")
                case .paused(let time):
                    print("paused: \(time ?? 0)")
                }
        }
    }
    
    func updateOnlineCount(onlineCount : OnlineUsers?){
        self.onlineCount.text = (onlineCount?.count ?? 0).description + " نفر"
    }
    
    @IBAction func answer(_ sender: Any) {
        
    }
    

    func setLottie(name : String){
        
        if(animationView?.superview != nil){
            self.animationView!.removeFromSuperview()
        }
        
        animationView = AnimationView(name: name)
        
        animationView!.frame.size = lottieView.frame.size
        
        animationView!.frame.origin = .init(x: 0, y: 0)
        
        animationView!.contentMode = UIView.ContentMode.scaleAspectFit
        
        animationView!.alpha = 1
        
        lottieView.addSubview(animationView!)
        
        animationView!.loopMode = .loop
        
        animationView!.play()
        
    }
    
}
