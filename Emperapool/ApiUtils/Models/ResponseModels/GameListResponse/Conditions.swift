/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Conditions : Codable {
	let gap_time : Int?
	let help_time : Int?
	let question_time : Int?
	let free_enter : Int?
	let available_late : Int?
	let available_skip : Int?
	let countdown_start : Int?
	let available_late_bug : Int?
	let question_levels : Int?
	let second_chance_available : String?
	let second_chance_gem : Int?
	let second_chance_coin : Int?
	let second_chance_reward_available : Int?
	let ratio : Int?
	let disable_loading : Int?
	let chat_type : Int?
	let bg : String?
	let chat_question : Int?
	let entry_available_time : Int?

	enum CodingKeys: String, CodingKey {

		case gap_time = "gap_time"
		case help_time = "help_time"
		case question_time = "question_time"
		case free_enter = "free_enter"
		case available_late = "available_late"
		case available_skip = "available_skip"
		case countdown_start = "countdown_start"
		case available_late_bug = "available_late_bug"
		case question_levels = "question_levels"
		case second_chance_available = "second_chance_available"
		case second_chance_gem = "second_chance_gem"
		case second_chance_coin = "second_chance_coin"
		case second_chance_reward_available = "second_chance_reward_available"
		case ratio = "ratio"
		case disable_loading = "disable_loading"
		case chat_type = "chat_type"
		case bg = "bg"
		case chat_question = "chat_question"
		case entry_available_time = "entry_available_time"
	}

}
