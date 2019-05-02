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
import UIColor_Hex_Swift

class QuestionViewController: UIViewController {
    

    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var questionView: DCBorderedView!
    @IBOutlet weak var isOfflineButton: DCBorderedButton!
    @IBOutlet weak var onlineCount: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var gem: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var timerView: UICircularTimerRing!
    @IBOutlet weak var backOfTimer: DCBorderedView!
    
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
    
    var currentQuestion : Question?
    
    var animationView : AnimationView?
    
    var selectedAnswer : Int = 0
    
    var itWasTrueAnswer : Bool = false
    
    var trueAnswer : Int = 0
    
    @IBOutlet weak var chartHelpButton: UIButton!
    @IBOutlet weak var timePlusHelpButton: UIButton!
    @IBOutlet weak var percentageHelpButton: UIButton!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var timePlusView: UIView!
    @IBOutlet weak var percentageView: UIView!
    
    
    
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
        self.enableInteractWithQuestion()
        self.selectedAnswer = 0
        self.itWasTrueAnswer = false
        self.currentQuestion = question
        self.questionLabel.text = question.question
        self.firstAnswer.setTitle(question.option_1, for: .normal)
        self.secondAnswer.setTitle(question.option_2, for: .normal)
        self.thirdAnswer.setTitle(question.option_3, for: .normal)
        self.backOfTimer.alpha = 1
        self.timerView.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 0
            self.questionView.setCenterX(x: self.view.centerX)
        }){completion in }
        self.timerView.startTimer(to: 10) { state in
                switch state {
                case .finished:
//                    print("finished")
                    UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                        self.questionView.setX(x: self.view.width)
                    }){completion in
                        self.timerView.resetTimer()
                        self.timerView.alpha = 0
                        self.backOfTimer.alpha = 0
                        self.questionView.setX(x: -1 * self.view.width)
                        self.calculateQuestion()
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
        selectedAnswer = (sender as! UIButton).tag
        (sender as! DCBorderedButton).normalBackgroundColor = UIColor("#844EB8")
        self.disableIntractWithQuestion()
        MR.answerQuestion(vc: self, gameId: (self.parent as! GameBoardViewController).gameRules?.id ?? 0, answer: (sender as! UIButton).tag, questionId: self.currentQuestion?.id ?? 0){res,statusCode  in
            if(res != nil){
                if(statusCode == 200){
                    //correct answer
                    self.itWasTrueAnswer = true
                    print("good for you")
                }else if(statusCode == 202){
                    //wrong answer
                    self.itWasTrueAnswer = false
                    print("preview popup wrong answer")
                    if(res?.extra_data != nil){
                        self.trueAnswer = res?.extra_data?.correct_answer ?? 0
                    }
                }
            }
        }
    }
    
    func disableIntractWithQuestion(){
        firstAnswer.isUserInteractionEnabled = false
        secondAnswer.isUserInteractionEnabled = false
        thirdAnswer.isUserInteractionEnabled = false
        chartHelpButton.isUserInteractionEnabled = false
        timePlusHelpButton.isUserInteractionEnabled = false
        percentageHelpButton.isUserInteractionEnabled = false
        chartView.alpha = 0.3
        timePlusView.alpha = 0.3
        percentageView.alpha = 0.3
    }
    
    func enableInteractWithQuestion(){
        firstAnswer.isUserInteractionEnabled = true
        secondAnswer.isUserInteractionEnabled = true
        thirdAnswer.isUserInteractionEnabled = true
        firstAnswer.normalBackgroundColor = UIColor.clear
        secondAnswer.normalBackgroundColor = UIColor.clear
        thirdAnswer.normalBackgroundColor = UIColor.clear
        
        chartHelpButton.isUserInteractionEnabled = true
        timePlusHelpButton.isUserInteractionEnabled = true
        percentageHelpButton.isUserInteractionEnabled = true
        chartView.alpha = 1
        timePlusView.alpha = 1
        percentageView.alpha = 1
        
    }
    
    func calculateQuestion(){
        
        if(itWasTrueAnswer){
            switch selectedAnswer {
            case 1:
                self.firstAnswer.normalBackgroundColor = UIColor("#8BD760")
            case 2:
                self.secondAnswer.normalBackgroundColor = UIColor("#8BD760")
            case 3:
                self.thirdAnswer.normalBackgroundColor = UIColor("#8BD760")
            default:
                print("nothing")
            }
            
            //type barikala
        }else{
            switch trueAnswer {
            case 1:
                self.firstAnswer.normalBackgroundColor = UIColor("#8BD760")
            case 2:
                self.secondAnswer.normalBackgroundColor = UIColor("#8BD760")
            case 3:
                self.thirdAnswer.normalBackgroundColor = UIColor("#8BD760")
            default:
                print("nothing")
            }
            
            switch selectedAnswer {
            case 1:
                self.firstAnswer.normalBackgroundColor = UIColor("#D1574B")
            case 2:
                self.secondAnswer.normalBackgroundColor = UIColor("#D1574B")
            case 3:
                self.thirdAnswer.normalBackgroundColor = UIColor("#D1574B")
            default:
                print("nothing")
            }
            
            //type fuck u
            
        }
        
        
        UIView.animate(withDuration: 0.2, delay: 1.0 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 0
            self.questionView.setCenterX(x: self.view.centerX)
        }){completion in }
        UIView.animate(withDuration: 0.2, delay: 5.0 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 1
            self.setLottie(name: "middlegame")
            self.questionView.setX(x: self.view.width)
        }){completion in
            self.questionView.setX(x: -1 * self.view.width)
        }
        
    }
    
    
    
    func notAnswer(){
        
    }
    
    
    @IBAction func chartHelp(_ sender: Any) {
    }
    
    @IBAction func timePlusHelp(_ sender: Any) {
    }
    
    @IBAction func percentageHelp(_ sender: Any) {
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
