//
//  MR-NEWS.swift
//  Emperapool
//
//  Created by MAC on 5/13/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift

extension MR {

    static func getNews(vc : UIViewController , completionHandler: @escaping (GenericResponse<[NewsRes] ,ExtraGameListRes>?) -> Void){
        request(EndPoints.news, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[NewsRes],ExtraGameListRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
}
