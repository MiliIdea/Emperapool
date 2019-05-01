/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct Question : Codable {
	let level : Int?
	let category_id : Int?
	let id : Int?
	let title : String?
	let question : String?
	let option_1 : String?
	let option_2 : String?
	let option_3 : String?
	let number_of_use : Int?
	let last_game_use : Int?
	let last_use : Int?
	let option_1_choose_count : Int?
	let option_2_choose_count : Int?
	let option_3_choose_count : Int?
	let created_at : Int?
	let updated_at : Int?
	let send_time : Int?

	enum CodingKeys: String, CodingKey {

		case level = "level"
		case category_id = "category_id"
		case id = "id"
		case title = "title"
		case question = "question"
		case option_1 = "option_1"
		case option_2 = "option_2"
		case option_3 = "option_3"
		case number_of_use = "number_of_use"
		case last_game_use = "last_game_use"
		case last_use = "last_use"
		case option_1_choose_count = "option_1_choose_count"
		case option_2_choose_count = "option_2_choose_count"
		case option_3_choose_count = "option_3_choose_count"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case send_time = "send_time"
	}

}
