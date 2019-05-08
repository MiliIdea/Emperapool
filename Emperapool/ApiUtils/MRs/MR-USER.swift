//
//  MR-USER.swift
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
    
    static func register(vc : UIViewController , phone : String   , completionHandler: @escaping (GenericResponse<[TokenRes] ,TokenRes>?) -> Void){
        request(EndPoints.register, method: .post , parameters: ["mobile" : phone] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[TokenRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func approveToken(vc : UIViewController , phone : String , activationCode : String   , completionHandler: @escaping (GenericResponse<[ProfileRes] ,TokenRes>?) -> Void){
        request(EndPoints.approveUserToken, method: .post , parameters: ["mobile" : phone , "activation_code" : activationCode] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<[ProfileRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    
    static func getProfile(vc : UIViewController , completionHandler: @escaping (GenericResponse<[ProfileRes] ,TokenRes>?) -> Void){
        request(EndPoints.getProfile, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[ProfileRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func getStatesList(vc : UIViewController , completionHandler: @escaping (GenericResponse<StatesListRes ,ProfileRes>?) -> Void){
        request(EndPoints.getStates, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<StatesListRes,ProfileRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func rewardVideo(vc : UIViewController , completionHandler: @escaping (GenericResponse<[ProfileRes] ,UserRes>?) -> Void){
        request(EndPoints.getStates, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[ProfileRes],UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func getMyBadge(vc : UIViewController , completionHandler: @escaping (GenericResponse<[Badges] ,UserRes>?) -> Void){
        request(EndPoints.getMyBadges, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[Badges],UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func updateUser(vc : UIViewController , profile : [String: Any] , completionHandler: @escaping (GenericResponse<[ProfileRes] ,TokenRes>?) -> Void){
        request(EndPoints.approveUserToken, method: .post , parameters: profile , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<[ProfileRes] ,TokenRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    
    static func getMyAvatars(vc : UIViewController , completionHandler: @escaping (GenericResponse<[Avatars] ,ExtraGameListRes>?) -> Void){
        request(EndPoints.myAvatars, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[Avatars],ExtraGameListRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
}
