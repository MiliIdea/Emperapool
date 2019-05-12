//
//  MR_PRIZE.swift
//  Emperapool
//
//  Created by MAC on 4/18/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift

extension MR {
    
    static func getPrizeList(vc : UIViewController , completionHandler: @escaping (GenericResponse<[PrizeRes] ,ExtraGameListRes>?) -> Void){
        request(EndPoints.prizeList, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[PrizeRes],ExtraGameListRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    static func getAvailableToBuyPrize(vc : UIViewController , productId : Int , completionHandler: @escaping (GenericResponse<PrizeAvailableRes ,UserRes>? , Int) -> Void){
        request(EndPoints.prizeAvailableToBuy + productId.description , method: .post , parameters: [:] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<PrizeAvailableRes,UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value, (res?.response!.statusCode)!)
            }
        }
        
    }
    
    static func payPrize(vc : UIViewController , productId : Int , bId : Int , refId : String , completionHandler: @escaping (GenericResponse<PrizeAvailableRes ,UserRes>? , Int) -> Void){
        request(EndPoints.payPrize + productId.description + "/" + refId + "/" + bId.description, method: .post , parameters: [:] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<PrizeAvailableRes,UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value, (res?.response!.statusCode)!)
            }
        }
        
    }
}


