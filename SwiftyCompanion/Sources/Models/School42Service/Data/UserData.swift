import Foundation

extension School42Service {
	public struct UserData: Decodable {
		public var login: String
		public var email: String
		public var wallet: Int
		public var curcusUsers: [CurcusData]
		
		enum CodingKeys: String, CodingKey {
			case login
			case email
			case wallet
			case curcusUsers = "curcus_users"
		}
	}
}
