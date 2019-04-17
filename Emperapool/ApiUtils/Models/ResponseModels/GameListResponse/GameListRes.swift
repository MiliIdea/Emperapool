/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GameListRes : Codable {
	let available_at_human : String?
	let expire_at_human : String?
	let icon : String?
	let image : String?
	let expire_at : Int?
	let is_featured : Bool?
	let is_free : Bool?
	let rules : Rules?
	let id : Int?
	let title : String?
	let description : String?
	let color : String?
	let entry_fee_gem : Int?
	let entry_fee_coin : Int?
	let entry_badge : String?
	let entry_count : Int?
	let answer_prize : String?
	let available_at : Int?
	let status : Int?
	let gorder : Int?

	enum CodingKeys: String, CodingKey {

		case available_at_human = "available_at_human"
		case expire_at_human = "expire_at_human"
		case icon = "icon"
		case image = "image"
		case expire_at = "expire_at"
		case is_featured = "is_featured"
		case is_free = "is_free"
		case rules = "rules"
		case id = "id"
		case title = "title"
		case description = "description"
		case color = "color"
		case entry_fee_gem = "entry_fee_gem"
		case entry_fee_coin = "entry_fee_coin"
		case entry_badge = "entry_badge"
		case entry_count = "entry_count"
		case answer_prize = "answer_prize"
		case available_at = "available_at"
		case status = "status"
		case gorder = "gorder"
	}

	

}
