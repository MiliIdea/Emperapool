/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct IntroRes : Codable {
	let last_version : Int?
	let direct_url : String?
	let store_url : String?
	let force_update : Bool?
	let ignore_update : Bool?
	let force_update_type : Int?
	let your_version : Int?
	let title : String?
	let description : String?
	let bad_words : [String]?
	let ir : Int?
	let chat_text : String?
	let share_text : String?
	let chat_words : [String]?
	let disable_chat_text : String?
	let disable_chat_sentences : [String]?

	enum CodingKeys: String, CodingKey {

		case last_version = "last_version"
		case direct_url = "direct_url"
		case store_url = "store_url"
		case force_update = "force_update"
		case ignore_update = "ignore_update"
		case force_update_type = "force_update_type"
		case your_version = "your_version"
		case title = "title"
		case description = "description"
		case bad_words = "bad_words"
		case ir = "ir"
		case chat_text = "chat_text"
		case share_text = "share_text"
		case chat_words = "chat_words"
		case disable_chat_text = "disable_chat_text"
		case disable_chat_sentences = "disable_chat_sentences"
	}


}
