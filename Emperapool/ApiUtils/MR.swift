//
//  MR.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire
import DCKit
import Toast_Swift

class MR {
    
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
    
    
    
    
    
    
    
    
    
    
    
    static func haveInternet() -> Bool{
        guard let status = Network.reachability?.status else { return false}
        if(status == .unreachable){
            return false
        }else{
            return true
        }
    }
    
    
    
    static func resHandler<T , V>(vc : UIViewController , response : DataResponse<GenericResponse<T , V>> , isShowToast : Bool = true , completionHandler: @escaping (DataResponse<GenericResponse<T , V>>?) -> Void){
        
        vc.view.isUserInteractionEnabled = true
        print(response.response?.debugDescription ?? "")
        print()
        print(response.response?.statusCode ?? "")
        if(response.response?.statusCode == 200 || response.response?.statusCode == 201){
            completionHandler(response)
        }else{
            if(response.response?.statusCode == 400){
                if let data = response.data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
                        {
                            var errors : String = ""
                            var count = 1
                            for s in (json.first?.value as? [String] ?? [String]()) {
                                errors.append(s)
                                if(json.count > count){
                                    errors.append("\n")
                                    count += 1
                                }
                            }
                            if(isShowToast){
                                vc.view.makeToast(errors)
                            }
                            //App.dismissLoading(vc: vc)
                            
                        } else {
                            print("bad json")
                            if(isShowToast){vc.view.makeToast("خطا در نوع اطلاعات")}
                        }
                    } catch let error as NSError {
                        print(error)
                        if(isShowToast){vc.view.makeToast("خطایی رخ داده است")}
                    }
                    
                }else{
                    if(isShowToast){vc.view.makeToast("خطا در دریافت اطلاعات")}
                }
            }else if(response.response?.statusCode == 401){
                vc.navigate(vc: LoginViewController.self){_ in }
                
            }else if(response.response?.statusCode == 500){
                if(isShowToast && MR.haveInternet()){vc.view.makeToast("خطا در سرور")}
            }else{
                print("staatus Code")
                print(response.response?.statusCode as Any)
                if(isShowToast && MR.haveInternet()){vc.view.makeToast("خطا در ارتباط به سرور")}
            }
            
            
        }
    }
    
    
}
