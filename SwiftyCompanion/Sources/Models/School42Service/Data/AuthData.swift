import Foundation

extension School42Service {
	public struct AuthData: Decodable {
		public var accessToken: String
		public var createdAt: Int
		public var expiresIn: Int // seconds
		public var scope: String
		public var tokenType: String
		
		enum CodingKeys: String, CodingKey {
			case accessToken = "access_token"
			case createdAt = "created_at"
			case expiresIn = "expires_in"
			case scope = "scope"
			case tokenType = "token_type"
		}
	}
}
