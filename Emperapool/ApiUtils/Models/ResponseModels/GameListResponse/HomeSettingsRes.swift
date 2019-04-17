/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct HomeSettingsRes : Codable {
	let player_register_coin : String?
	let player_register_gem : String?
	let player_introduce_coin : String?
	let player_introduce_gem : String?
	let exchange_gem_to_coin : String?
	let add_question_coin : String?
	let add_question_gem : String?
	let reward_view_coin : String?
	let reward_view_gem : String?
	let chat_server_address : String?
	let wof_prize : String?
	let player_instagram_coin : String?
	let player_instagram_gem : String?
	let chat_server_port_number : String?

	enum CodingKeys: String, CodingKey {

		case player_register_coin = "player_register_coin"
		case player_register_gem = "player_register_gem"
		case player_introduce_coin = "player_introduce_coin"
		case player_introduce_gem = "player_introduce_gem"
		case exchange_gem_to_coin = "exchange_gem_to_coin"
		case add_question_coin = "add_question_coin"
		case add_question_gem = "add_question_gem"
		case reward_view_coin = "reward_view_coin"
		case reward_view_gem = "reward_view_gem"
		case chat_server_address = "chat_server_address"
		case wof_prize = "wof_prize"
		case player_instagram_coin = "player_instagram_coin"
		case player_instagram_gem = "player_instagram_gem"
		case chat_server_port_number = "chat_server_port_number"
	}

}
