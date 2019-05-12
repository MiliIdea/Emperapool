/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct PrizeAvailableRes : Codable {
	let pid : Int?
	let status : Int?
	let prize : Prize?
	let ready_to_request : Bool?
	let available_to_request : Bool?
	let special_msg : String?
	let ref_code : String?
	let next_step : Int?
	let before_buy : Bool?

	enum CodingKeys: String, CodingKey {

		case pid = "pid"
		case status = "status"
		case prize = "prize"
		case ready_to_request = "ready_to_request"
		case available_to_request = "available_to_request"
		case special_msg = "special_msg"
		case ref_code = "ref_code"
		case next_step = "next_step"
		case before_buy = "before_buy"
	}


}
