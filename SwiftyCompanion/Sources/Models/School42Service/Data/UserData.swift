import Foundation

extension School42Service {
	public struct UserData: Decodable {
		public var login: String
		public var imageUrl: String
		public var location: String?
		public var wallet: Int
		public var cursusUsers: [CursusUserData]
		public var projectsUsers: [ProjectUserData]
		
		enum CodingKeys: String, CodingKey {
			case login
			case imageUrl = "image_url"
			case location
			case wallet
			case cursusUsers = "cursus_users"
			case projectsUsers = "projects_users"
		}
	}
}
