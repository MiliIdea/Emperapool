/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct NewsRes : Codable {
	let featured_image : String?
	let id : Int?
	let title : String?
	let summary : String?
	let content : String?
	let status : Int?
	let rel_btn_text : String?
	let rel_type : String?
	let rel_ids : String?
	let admin_id : Int?
	let created_at : Int?
	let updated_at : Int?

	enum CodingKeys: String, CodingKey {

		case featured_image = "featured_image"
		case id = "id"
		case title = "title"
		case summary = "summary"
		case content = "content"
		case status = "status"
		case rel_btn_text = "rel_btn_text"
		case rel_type = "rel_type"
		case rel_ids = "rel_ids"
		case admin_id = "admin_id"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

}
