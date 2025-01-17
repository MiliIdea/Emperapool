//
//  MR-LEADERBOARDs.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift

extension MR {

    static func getOverallLeaderboard(vc : UIViewController , completionHandler: @escaping (GenericResponse<[LeaderboardRes<Int>] ,ExtraLeaderboardRes<Int>>?) -> Void){
        request(EndPoints.overallLeaderboard, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[LeaderboardRes],ExtraLeaderboardRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func getMonthLeaderboard(vc : UIViewController , completionHandler: @escaping (GenericResponse<[LeaderboardRes<String>] ,ExtraLeaderboardRes<String>>?) -> Void){
        request(EndPoints.monthLeaderboard, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[LeaderboardRes],ExtraLeaderboardRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func getGameLeaderboard(vc : UIViewController , gameId : String , completionHandler: @escaping (GenericResponse<[LeaderboardRes<String>] ,ExtraLeaderboardRes<String>>?) -> Void){
        request((EndPoints.gameLeaderboard + gameId), method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[LeaderboardRes],ExtraLeaderboardRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    
    
}
