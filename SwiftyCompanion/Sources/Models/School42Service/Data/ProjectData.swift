import Foundation

extension School42Service {
	public struct ProjectData: Decodable {
		public var name: String
		
		enum CodingKeys: String, CodingKey {
			case name
		}
	}
}
