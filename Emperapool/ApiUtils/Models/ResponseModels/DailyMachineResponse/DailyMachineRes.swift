/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DailyMachineRes : Codable {

    let icon : String?
    let image : String?
    let options : [Options]?
    let id : Int?
    let title : String?
    let entry_fee : Int?
    let available_period : String?
    let period_count : Int?
    let number_player : Int?
    let total_earn_coin : Int?
    let total_earn_gem : Int?
    let free_entry_available : Int?
    let wp_entry_available : Int?
    let status : Int?
    let is_free : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case icon = "icon"
        case image = "image"
        case options = "options"
        case id = "id"
        case title = "title"
        case entry_fee = "entry_fee"
        case available_period = "available_period"
        case period_count = "period_count"
        case number_player = "number_player"
        case total_earn_coin = "total_earn_coin"
        case total_earn_gem = "total_earn_gem"
        case free_entry_available = "free_entry_available"
        case wp_entry_available = "wp_entry_available"
        case status = "status"
        case is_free = "is_free"
    }

}
