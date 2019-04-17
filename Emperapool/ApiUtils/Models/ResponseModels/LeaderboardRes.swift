//
//  LeaderboardRes.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct LeaderboardRes : Codable {
    
    let avatar : String?
    
    let birthday : String?
    
    let id : Int?
    
    let display_name : String?
    
    let point : Int?
    
    let level : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case avatar = "avatar"
        
        case birthday = "birthday"
        
        case id = "id"
        
        case display_name = "display_name"
        
        case point = "point"
        
        case level = "level"
        
    }
    
}
