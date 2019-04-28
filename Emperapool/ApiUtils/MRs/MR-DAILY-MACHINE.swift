//
//  MR-DailyMachine.swift
//  Emperapool
//
//  Created by MAC on 4/24/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift


extension MR {
    
    static func getDailyMachine(vc : UIViewController , completionHandler: @escaping (GenericResponse<[DailyMachineRes] ,UserRes>?) -> Void){
        request(EndPoints.getDailyMachine, method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[DailyMachineRes],UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
    static func getRollMachine(vc : UIViewController , machineId : String , completionHandler: @escaping (GenericResponse<[DailyMachineRes] ,UserRes>?) -> Void){
        request((EndPoints.getRoll + machineId), method: .get , headers: App.publicHeader(api :  "1")).validate().responseDecodableObject(decoder: App.decoder) { (response : DataResponse<GenericResponse<[DailyMachineRes],UserRes>>) in
            self.resHandler(vc: vc, response: response){res in
                completionHandler(res?.result.value)
            }
        }
        
    }
    
    
}
