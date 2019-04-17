//
//  ExtraGameListRes.swift
//  Emperapool
//
//  Created by MAC on 4/17/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct ExtraGameListRes : Codable {
    let user : UserRes?
    let homeSettings : HomeSettingsRes?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "user"
        case homeSettings = "home_settings"
    }
    
}
