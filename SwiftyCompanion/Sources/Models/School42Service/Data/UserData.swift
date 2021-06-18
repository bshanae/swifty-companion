import Foundation

extension School42Service {
	public struct UserData: Decodable {
		public var login: String
		public var email: String
		public var wallet: Int
		public var cursusUsers: [CurcusUserData]
		public var projectsUsers: [ProjectUserData]
		
		enum CodingKeys: String, CodingKey {
			case login
			case email
			case wallet
			case cursusUsers = "cursus_users"
			case projectsUsers = "projects_users"
		}
	}
}
