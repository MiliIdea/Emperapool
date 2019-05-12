/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Product : Codable {
	let id : Int?
	let title : String?
	let description : String?
	let prd_type : String?
	let icon : String?
	let image : String?
	let color : String?
	let number_of_item : Int?
	let price_type : Int?
	let price : String?
	let special_price : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case description = "description"
		case prd_type = "prd_type"
		case icon = "icon"
		case image = "image"
		case color = "color"
		case number_of_item = "number_of_item"
		case price_type = "price_type"
		case price = "price"
		case special_price = "special_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		prd_type = try values.decodeIfPresent(String.self, forKey: .prd_type)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		number_of_item = try values.decodeIfPresent(Int.self, forKey: .number_of_item)
		price_type = try values.decodeIfPresent(Int.self, forKey: .price_type)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		special_price = try values.decodeIfPresent(Int.self, forKey: .special_price)
	}

}