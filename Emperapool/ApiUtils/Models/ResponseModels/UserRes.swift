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
    
    let choice : Int?
    
    let next_available_roll : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "user"
        
        case choice = "choice"
        
        case next_available_roll = "next_available_roll"
        
    }
    
}
