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
    @IBOutlet weak var questionCoinBox: UIView!
    @IBOutlet weak var questionCoinLabel: UILabel!
    @IBOutlet weak var gem: UILabel!
    @IBOutlet weak var questionGemLabel: UILabel!
    @IBOutlet weak var questionGemBox: UIView!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var timerView: UICircularTimerRing!
    @IBOutlet weak var backOfTimer: DCBorderedView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var fHelp: DCBorderedView!
    @IBOutlet weak var firstAnswer: DCBorderedButton!
    @IBOutlet weak var sHelp: DCBorderedView!
    @IBOutlet weak var secondAnswer: DCBorderedButton!
    @IBOutlet weak var tHelp: DCBorderedView!
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
    
    @IBOutlet weak var fiftyHelpButton: UIButton!
    @IBOutlet weak var timePlusHelpButton: UIButton!
    @IBOutlet weak var percentageHelpButton: UIButton!
    @IBOutlet weak var fiftyView: UIView!
    @IBOutlet weak var timePlusView: UIView!
    @IBOutlet weak var percentageView: UIView!
    
    var scoreCalculator : ScoreCalculatorInQuestion?
    
    var availableSkip : Int = 0
    
    var iAmLoser : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.questionView.setX(x: -1 * self.questionView.width)

        self.timerView.layer.cornerRadius = self.timerView.width / 2
        
        self.timerView.backgroundColor = .white
        
        self.timerView.valueFormatter = UICircularProgressRingFormatter.init(valueIndicator: "", rightToLeft: true, showFloatingPoint: false, decimalPlaces: 2)
        
        self.timerView.innerCapStyle = .round
        
        self.timerView.backgroundColor = .clear
        
        self.timerView.font = UIFont.init(name: "Shabnam-FD", size: 23)!

        self.coin.text = (App.profile?.coin ?? 0).description
        
        self.gem.text = (App.profile?.gem ?? 0).description
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.setLottie(name: "startgamepage")
        let gameRules = (self.parent as! GameBoardViewController).gameRules
        self.scoreCalculator = ScoreCalculatorInQuestion.init(myGem: App.profile?.gem ?? 0, myCoin: App.profile?.coin ?? 0, prizes: gameRules?.rules?.prize ?? [Prize]() , fifty : gameRules?.rules?.help?.fifty?.available ?? 0, fiftyPrice: gameRules?.rules?.help?.fifty?.price ?? 0 , time: gameRules?.rules?.help?.time?.available ?? 0, timePrice: gameRules?.rules?.help?.time?.price ?? 0 , chart : gameRules?.rules?.help?.chart?.available ?? 0, chartPrice: gameRules?.rules?.help?.chart?.price ?? 0)
        
    }
    
    @IBAction func close(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        
        let vc : EndGamePopupViewController = (storyboard.instantiateViewController(withIdentifier: "EndGamePopupViewController")) as! EndGamePopupViewController
        
        vc.scoreCalculator = self.scoreCalculator
        
        self.parent!.addChild(vc)
        
        vc.didMove(toParent: self.parent!)
        
        self.parent!.view.addSubview(vc.view)
    }
    
    
    func previewQuestion(question : Question){
        if(iAmLoser){
            return
        }
        self.fiftyPercentCoin.text = (self.scoreCalculator?.fiftyPrice)?.description
        self.fiftyPercentAmount.text = (self.scoreCalculator?.fifty)?.description
        self.timePlusCoin.text = (self.scoreCalculator?.timePrice)?.description
        self.timePlusAmount.text = (self.scoreCalculator?.time)?.description
        self.percentageCoin.text = (self.scoreCalculator?.chartPrice)?.description
        self.percentageAmount.text = (self.scoreCalculator?.chart)?.description

        self.enableInteractWithQuestion()
        self.questionNumber.text = "سوال " + ((self.scoreCalculator?.questionNumber ?? 1).description)
        self.selectedAnswer = 0
        self.itWasTrueAnswer = false
        self.currentQuestion = question
        self.questionLabel.text = question.question
        self.firstAnswer.setTitle(question.option_1, for: .normal)
        self.secondAnswer.setTitle(question.option_2, for: .normal)
        self.thirdAnswer.setTitle(question.option_3, for: .normal)
        self.backOfTimer.alpha = 1
        self.timerView.alpha = 1
        self.setPrizeInQuestion()
        let gameRules = (self.parent as! GameBoardViewController).gameRules
        
        (self.parent as! GameBoardViewController).chatViewController?.stopChat(time: gameRules?.rules?.conditions?.question_time ?? 10 , chatQuestionType : gameRules?.rules?.conditions?.chat_question ?? 1)
        
        UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 0
            self.questionView.setCenterX(x: self.view.centerX)
        }){completion in }
        self.timerView.startTimer(to: TimeInterval(gameRules?.rules?.conditions?.question_time ?? 10)) { state in
                switch state {
                case .finished:
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
    
    func setPrizeInQuestion(){
        let scoreOfQuestion = self.scoreCalculator?.getScoreOfQuestion()
        if(scoreOfQuestion?.coin == 0){
            self.questionCoinBox.alpha = 0
        }
        if(scoreOfQuestion?.gem == 0){
            self.questionGemBox.alpha = 0
            self.questionCoinBox.setX(x: self.questionGemBox.x)
        }
        self.questionCoinLabel.text = scoreOfQuestion?.coin.description
        self.questionGemLabel.text = scoreOfQuestion?.gem.description
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
        fiftyHelpButton.isUserInteractionEnabled = false
        fiftyView.alpha = 0.3
        timePlusHelpButton.isUserInteractionEnabled = false
        timePlusView.alpha = 0.3
        percentageHelpButton.isUserInteractionEnabled = false
        percentageView.alpha = 0.3
        
    }
    
    func enableInteractWithQuestion(){
        firstAnswer.isUserInteractionEnabled = true
        secondAnswer.isUserInteractionEnabled = true
        thirdAnswer.isUserInteractionEnabled = true
        self.firstAnswer.alpha = 1
        self.secondAnswer.alpha = 1
        self.thirdAnswer.alpha = 1
        firstAnswer.normalBackgroundColor = UIColor.clear
        secondAnswer.normalBackgroundColor = UIColor.clear
        thirdAnswer.normalBackgroundColor = UIColor.clear
        
        fiftyHelpButton.isUserInteractionEnabled = true
        timePlusHelpButton.isUserInteractionEnabled = true
        percentageHelpButton.isUserInteractionEnabled = true
        fiftyView.alpha = 1
        timePlusView.alpha = 1
        percentageView.alpha = 1
        
        fHelp.alpha = 0
        fHelp.frame.size = firstAnswer.frame.size
        sHelp.alpha = 0
        sHelp.frame.size = secondAnswer.frame.size
        tHelp.alpha = 0
        tHelp.frame.size = tHelp.frame.size
        
        if(self.scoreCalculator?.chart == 0 || self.scoreCalculator?.myScore.coin ?? 0 < self.scoreCalculator?.chartPrice ?? 0){
            percentageHelpButton.isUserInteractionEnabled = false
            percentageView.alpha = 0.3
        }
        
        if(self.scoreCalculator?.time == 0 || self.scoreCalculator?.myScore.coin ?? 0 < self.scoreCalculator?.timePrice ?? 0){
            timePlusHelpButton.isUserInteractionEnabled = false
            timePlusView.alpha = 0.3
        }
        
        if(self.scoreCalculator?.fifty == 0 || self.scoreCalculator?.myScore.coin ?? 0 < self.scoreCalculator?.fiftyPrice ?? 0){
            fiftyHelpButton.isUserInteractionEnabled = false
            fiftyView.alpha = 0.3
        }
        
    }
    
    func calculateQuestion(){
        
        if(itWasTrueAnswer){
            self.scoreCalculator?.goNextQuestion()
            
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
            
            self.iAmLoser = true
            
            if(selectedAnswer == 0){
                //ag dg soal baraye rad kardan nadasht showlosepopup
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
                
            }
            
        }
        
        self.coin.text = self.scoreCalculator?.myScore.coin.description
        self.gem.text = self.scoreCalculator?.myScore.gem.description
        
        UIView.animate(withDuration: 0.2, delay: 0.5 , options: .curveEaseInOut, animations: {
            self.lottieView.alpha = 0
            self.questionView.setCenterX(x: self.view.centerX)
        }){completion in }
        UIView.animate(withDuration: 0.2, delay: 2.0 , options: .curveEaseInOut, animations: {
            if(!self.iAmLoser){
                self.lottieView.alpha = 1
                self.setLottie(name: "middlegame")
            }else{
                self.lottieView.alpha = 0
            }
            self.questionView.setX(x: self.view.width)
            
        }){completion in
            self.questionView.setX(x: -1 * self.view.width)
            if(self.iAmLoser){
                self.showLosePopup()
            }
        }
        
    }
    
    func showLosePopup(){

        self.iAmLoser = true
        
        (self.parent as! GameBoardViewController).xmpp?.xmppStream.disconnect()
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        
        let vc : LoserPopupViewController = (storyboard.instantiateViewController(withIdentifier: "LoserPopupViewController")) as! LoserPopupViewController
        
        vc.scoreCalculator = self.scoreCalculator
        
        self.parent!.addChild(vc)
        
        vc.didMove(toParent: self.parent!)
        
        self.parent!.view.addSubview(vc.view)
        //show popup
    }
    
    
    
    @IBAction func fiftyHelp(_ sender: Any) {
        fiftyHelpButton.isUserInteractionEnabled = false
        fiftyView.alpha = 0.3
        timePlusHelpButton.isUserInteractionEnabled = false
        timePlusView.alpha = 0.3
        percentageHelpButton.isUserInteractionEnabled = false
        percentageView.alpha = 0.3
        MR.helpFifty(vc: self, gameId: (self.parent as! GameBoardViewController).gameRules?.id ?? 0, questionId: self.currentQuestion?.id ?? 0){res , status in
            self.scoreCalculator?.useFiftyHelp()
            if(status == 200 && res?.extra_data != nil){
                switch res?.extra_data?.wrong_answer ?? 0 {
                case 1 :
                    self.firstAnswer.alpha = 0.3
                    self.firstAnswer.isUserInteractionEnabled = false
                case 2 :
                    self.secondAnswer.alpha = 0.3
                    self.secondAnswer.isUserInteractionEnabled = false
                case 3 :
                    self.thirdAnswer.alpha = 0.3
                    self.thirdAnswer.isUserInteractionEnabled = false
                default:
                    print("hichi")
                }
            }
        }
    }
    
    @IBAction func timePlusHelp(_ sender: Any) {
        fiftyHelpButton.isUserInteractionEnabled = false
        fiftyView.alpha = 0.3
        timePlusHelpButton.isUserInteractionEnabled = false
        timePlusView.alpha = 0.3
        percentageHelpButton.isUserInteractionEnabled = false
        percentageView.alpha = 0.3
        MR.helpExtraTime(vc: self, gameId: (self.parent as! GameBoardViewController).gameRules?.id ?? 0, questionId: self.currentQuestion?.id ?? 0){res , status in
            self.scoreCalculator?.useTimeHelp()
            if(status == 200){
                //ezfae kardan time
                self.timerView.pauseTimer()
                let timePlus : Double = Double((self.parent as! GameBoardViewController).gameRules?.rules?.conditions?.help_time ?? 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + timePlus) {
                    self.timerView.continueTimer()
                }
            }
        }
    }
    
    @IBAction func percentageHelp(_ sender: Any) {
        fiftyHelpButton.isUserInteractionEnabled = false
        fiftyView.alpha = 0.3
        timePlusHelpButton.isUserInteractionEnabled = false
        timePlusView.alpha = 0.3
        percentageHelpButton.isUserInteractionEnabled = false
        percentageView.alpha = 0.3
        MR.helpChart(vc: self, gameId: (self.parent as! GameBoardViewController).gameRules?.id ?? 0, questionId: self.currentQuestion?.id ?? 0){res , status in
            self.scoreCalculator?.useChartHelp()
            if(status == 200 && res?.extra_data != nil){
                self.fHelp.setWidth(width: self.firstAnswer.width * CGFloat((res?.extra_data?.chart![0])!) / CGFloat(100))
                self.sHelp.setWidth(width: self.secondAnswer.width * CGFloat((res?.extra_data?.chart![1])!) / CGFloat(100))
                self.tHelp.setWidth(width: self.thirdAnswer.width * CGFloat((res?.extra_data?.chart![2])!) / CGFloat(100))
                self.fHelp.alpha = 0.3
                self.sHelp.alpha = 0.3
                self.tHelp.alpha = 0.3
                self.fHelp.setRight(right: self.firstAnswer.rightX)
                self.sHelp.setRight(right: self.secondAnswer.rightX)
                self.tHelp.setRight(right: self.thirdAnswer.rightX)
            }
        }
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
