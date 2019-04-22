//
//  ExtraLeaderboardRes.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct ExtraLeaderboardRes<T : Codable> : Codable {
    
    let self_rank : T?
    
    let point_earn : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case self_rank = "self_rank"
        
        case point_earn = "point_earn"
        
    }
    
}
