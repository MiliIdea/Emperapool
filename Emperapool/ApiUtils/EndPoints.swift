//
//  EndPoints.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public class EndPoints {
    
    static let baseUrl : String = "https://api.emperapool.com/api/v2/"
    
    //- MARK: User
    
    static let register : String = baseUrl + "user/auth/register"
    
    static let approveUserToken : String = baseUrl + "user/auth/approve"
    
    static let updateUser : String = baseUrl + "user/profile/update"
    
    static let getProfile : String = baseUrl + "user/profile/get/self"
    
    static let getStates : String = baseUrl + "user/profile/list/states"
    
    static let getMyBadges : String = baseUrl + "shop/badge/mybadge"
    
    static let rewardVideo : String = baseUrl + "user/profile/reward/video"
    
    //- MARK: Leaderboards
    
    static let overallLeaderboard : String = baseUrl + "user/leaderboard/overall"
    
    static let monthLeaderboard : String = baseUrl + "user/leaderboard/month"
    
    static let gameLeaderboard : String = baseUrl + "user/leaderboard/game/"
    
    //- MARK: Game
    
    static let gameList : String = baseUrl + "game/list"
    
    static let joinGame : String = baseUrl + "game/join"
    
    static let answerQuestion : String = baseUrl + "game/second-chance/video"
    
    //- MARK: Prize
    
    static let prizeList : String = baseUrl + "shop/prize/list"
    
    //- MARK: Shop
    
    static let shopList : String = baseUrl + "shop/list"
    
    //- MARK: DailyMachine
    
    static let getDailyMachine : String = baseUrl + "luck/wof/list"
    
    static let getRoll : String = baseUrl + "luck/wof/roll/"
}
