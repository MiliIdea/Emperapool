//
//  MR-INTRO.swift
//  Emperapool
//
//  Created by MAC on 5/2/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift


extension MR {
    
    static func getIntro(vc : UIViewController , completionHandler: @escaping (IntroRes?) -> Void){
        request(EndPoints.intro, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<IntroRes>) in
            completionHandler(response.result.value)
        }
    }
    
    
}
