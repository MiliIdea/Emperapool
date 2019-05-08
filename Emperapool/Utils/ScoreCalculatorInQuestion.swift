//
//  ScoreCalculatorInQuestion.swift
//  Emperapool
//
//  Created by MAC on 5/4/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public class ScoreCalculatorInQuestion {
    var rules : [Prize] = [Prize]()
    var questionNumber : Int = 1
    var myScore : ScoreModel
    var atFirstMyScore : ScoreModel
    var questionScores : ScoreModel
    var usedCoin : Int
    var fifty : Int
    var fiftyPrice : Int
    var chart : Int
    var chartPrice : Int
    var time : Int
    var timePrice : Int
    var skipQuestion : Int
    var skipAmount : Int
    
    init(myGem : Int , myCoin : Int , prizes : [Prize] , fifty : Int ,fiftyPrice : Int , time : Int ,timePrice : Int , chart : Int , chartPrice : Int , skipQuestion : Int) {
        self.rules = prizes
        myScore = .init(coin: myCoin, gem: myGem)
        atFirstMyScore = myScore
        questionScores = .init(coin: 0, gem: 0)
        self.fifty = fifty
        self.fiftyPrice = fiftyPrice
        self.chart = chart
        self.chartPrice = chartPrice
        self.time = time
        self.timePrice = timePrice
        self.usedCoin = 0
        self.skipQuestion = skipQuestion
        self.skipAmount = skipQuestion
    }
    
    func getScoreOfQuestion() -> ScoreModel{
        var result : ScoreModel = .init(coin: 0, gem: 0)
        var intSkip = self.skipAmount - skipQuestion
        for r in rules {
            if(r.period == nil){
                return .init(coin: 0, gem: 0)
            }
            if(r.type == "once"){
                if((questionNumber - intSkip) == r.period){
                    result.coin += r.coin ?? 0
                    result.gem += r.gem ?? 0
                }
            }else{//repeat
                if((questionNumber - intSkip) % r.period! == 0){
                    result.coin += r.coin ?? 0
                    result.gem += r.gem ?? 0
                }
            }
        }
        return result
    }
    
    func goNextQuestion(){
        self.myScore.coin += getScoreOfQuestion().coin
        self.myScore.gem  += getScoreOfQuestion().gem
        
        self.questionScores.coin += getScoreOfQuestion().coin
        self.questionScores.gem  += getScoreOfQuestion().gem
        
        self.questionNumber += 1
    }
    
    func skipThisQuestion(){
        self.questionNumber += 1
    }
    
    
    func useTimeHelp(){
        self.time -= 1
        self.myScore.coin -= self.timePrice
        self.usedCoin += self.timePrice
    }
    
    func useChartHelp(){
        self.chart -= 1
        self.myScore.coin -= self.chartPrice
        self.usedCoin += self.chartPrice
    }
    
    func useFiftyHelp(){
        self.fifty -= 1
        self.myScore.coin -= self.fiftyPrice
        self.usedCoin += self.fiftyPrice
    }
    
}


public struct ScoreModel {
    var coin : Int
    var gem : Int
    init(coin : Int , gem : Int) {
        self.coin = coin
        self.gem = gem
    }
}
