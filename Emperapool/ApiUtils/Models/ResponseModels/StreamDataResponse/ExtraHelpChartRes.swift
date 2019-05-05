//
//  ExtraHelpChart.swift
//  Emperapool
//
//  Created by MAC on 5/4/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation

public struct ExtraHelpChartRes : Codable {
    
    let chart : [Int]?
    
    enum CodingKeys: String, CodingKey {
        
        case chart = "chart"
        
    }
    
}
