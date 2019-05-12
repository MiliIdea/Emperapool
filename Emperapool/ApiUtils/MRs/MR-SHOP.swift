//
//  MR-SHOP.swift
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
    
    static func getShopList(vc : UIViewController , completionHandler: @escaping (GenericResponse<ShopListRes ,ExtraGameListRes>?) -> Void){
        request(EndPoints.shopList, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<ShopListRes,ExtraGameListRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func getAvailableToBuy(vc : UIViewController , productId : Int , completionHandler: @escaping (GenericResponse<AvailableToBuyRes ,UserRes>? , Int) -> Void){
        request(EndPoints.productAvailableToBuy + productId.description , method: .post , parameters: [:] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<AvailableToBuyRes,UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value, (res?.response!.statusCode)!)
            }
        }
        
    }
    
    static func payProduct(vc : UIViewController , productId : Int , bId : Int , completionHandler: @escaping (GenericResponse<AvailableToBuyRes ,UserRes>? , Int) -> Void){
        request(EndPoints.payProduct + productId.description + "/" + bId.description, method: .post , parameters: [:] , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response :
            DataResponse<GenericResponse<AvailableToBuyRes,UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value, (res?.response!.statusCode)!)
            }
        }
        
    }
    
    
}
