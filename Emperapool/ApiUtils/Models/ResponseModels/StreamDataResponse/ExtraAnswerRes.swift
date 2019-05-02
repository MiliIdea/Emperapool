//
//  ExtraAnswerRes.swift
//  Emperapool
//
//  Created by MAC on 5/2/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public struct ExtraAnswerRes : Codable {
    let correct_answer : Int?
    let allow_reward_video : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case correct_answer = "correct_answer"
        case allow_reward_video = "allow_reward_video"
        
    }
    
}

