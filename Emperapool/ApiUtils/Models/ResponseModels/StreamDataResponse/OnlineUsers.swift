//
//  OnlineUsers.swift
//  Emperapool
//
//  Created by MAC on 4/28/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public struct OnlineUsers : Codable {
    let count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case count = "count"
    }
    
}
