//
//  ExtraJoinGameRes.swift
//  Emperapool
//
//  Created by MAC on 5/2/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public struct ExtraJoinGameRes : Codable {
    let chat_room : String?
    let data_room : String?
    
    enum CodingKeys: String, CodingKey {
        
        case chat_room = "chat_room"
        case data_room = "data_room"
        
    }
    
}
