//
//  App.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit

public class App {
    
    static let defaults: UserDefaults = UserDefaults.standard
    
    static var decoder : JSONDecoder {
        get{
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return decoder
        }
    }
    
    static func publicHeader(_ token : String = (App.defaults.object(forKey: DefaultStrings.token) as? String) ?? "" , api : String = "1.0") -> [String : String] {
        var head = ["os" : "iOS" , "os-version" : UIDevice.current.systemVersion , "app-version" : Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String , "api-version" : api]
        if(token != ""){
            head["Authorization"] = "bearer " + token
            print(head["Authorization"] as Any)
        }

        return head
    }
    
}
