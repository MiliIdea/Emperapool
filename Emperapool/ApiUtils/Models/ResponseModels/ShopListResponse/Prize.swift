/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Prize : Codable {
	let id : Int?
	let image : String?
	let icon : String?
	let title : String?
	let description : String?
	let color : String?
	let gem : Int?
	let coin : Int?
	let is_featured : Bool?
	let has_stock : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case image = "image"
		case icon = "icon"
		case title = "title"
		case description = "description"
		case color = "color"
		case gem = "gem"
		case coin = "coin"
		case is_featured = "is_featured"
		case has_stock = "has_stock"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		gem = try values.decodeIfPresent(Int.self, forKey: .gem)
		coin = try values.decodeIfPresent(Int.self, forKey: .coin)
		is_featured = try values.decodeIfPresent(Bool.self, forKey: .is_featured)
		has_stock = try values.decodeIfPresent(Int.self, forKey: .has_stock)
	}

}