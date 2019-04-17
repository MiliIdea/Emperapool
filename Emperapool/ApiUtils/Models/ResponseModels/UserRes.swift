//
//  UserRes.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct UserRes : Codable {
    
    let user : ProfileRes?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "user"
        
    }
    
}
