//
//  ExtraLeaderboardRes.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct ExtraLeaderboardRes : Codable {
    
    let self_rank : String?
    
    let point_earn : String?
    
    enum CodingKeys: String, CodingKey {
        
        case self_rank = "self_rank"
        
        case point_earn = "point_earn"
        
    }
    
}
