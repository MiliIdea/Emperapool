//
//  ExtraHelpFifty.swift
//  Emperapool
//
//  Created by MAC on 5/4/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public struct ExtraHelpFiftyRes : Codable {
    
    let wrong_answer : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case wrong_answer = "wrong_answer"
        
    }
    
}
