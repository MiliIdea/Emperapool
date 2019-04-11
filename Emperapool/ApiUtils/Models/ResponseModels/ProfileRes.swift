/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ProfileRes : Codable {
	let avatar : String?
	let status : String?
	let birthday : String?
	let id : Int?
	let username : String?
	let display_name : String?
	let mobile : String?
	let introduce_code : String?
	let introduced_by : String?
	let activation_code : Int?
	let coin : Int?
	let coin_total : Int?
	let gem : Int?
	let gem_total : Int?
	let credit : String?
	let level : Int?
	let xp : Int?
	let chat_token : String?
	let instagram_gift : Bool?
	let has_unread_ticket : Bool?
	let has_unread_message : Bool?
	let firebase : String?
	let city : String?
	let job : String?
	let video_reward_total : Int?
	let video_reward_available : Int?
	let video_reward_lastuse : Int?

	enum CodingKeys: String, CodingKey {

		case avatar = "avatar"
		case status = "status"
		case birthday = "birthday"
		case id = "id"
		case username = "username"
		case display_name = "display_name"
		case mobile = "mobile"
		case introduce_code = "introduce_code"
		case introduced_by = "introduced_by"
		case activation_code = "activation_code"
		case coin = "coin"
		case coin_total = "coin_total"
		case gem = "gem"
		case gem_total = "gem_total"
		case credit = "credit"
		case level = "level"
		case xp = "xp"
		case chat_token = "chat_token"
		case instagram_gift = "instagram_gift"
		case has_unread_ticket = "has_unread_ticket"
		case has_unread_message = "has_unread_message"
		case firebase = "firebase"
		case city = "city"
		case job = "job"
		case video_reward_total = "video_reward_total"
		case video_reward_available = "video_reward_available"
		case video_reward_lastuse = "video_reward_lastuse"
	}

}
