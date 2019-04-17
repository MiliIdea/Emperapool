//
//  StatesListRes.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

struct StatesListRes : Codable {
    
    let cities : [String]?
    
    let jobs :  [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case cities = "cities"
        
        case jobs = "jobs"
        
    }
    
}
