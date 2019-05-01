//
//  MR-GAME.swift
//  Emperapool
//
//  Created by MAC on 4/17/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift

extension MR {

    static func getGameList(vc : UIViewController , completionHandler: @escaping (GenericResponse<[GameListRes] ,ExtraGameListRes>?) -> Void){
        request(EndPoints.gameList, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[GameListRes],ExtraGameListRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func joinGame(vc : UIViewController , gameId : Int  , answer : Int , questionId : Int  , completionHandler: @escaping (GenericResponse<[ProfileRes] ,TokenRes>?) -> Void){
        request(EndPoints.joinGame, method: .post , parameters: ["gameId" : gameId , "answer" : answer , "questionId" : questionId] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<[ProfileRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func answerQuestion(vc : UIViewController , gameId : Int  , answer : Int , questionId : Int  , completionHandler: @escaping (GenericResponse<[ProfileRes] ,TokenRes>?) -> Void){
        request(EndPoints.answerQuestion, method: .post , parameters: ["gameId" : gameId , "answer" : answer , "questionId" : questionId] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<[ProfileRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
}
