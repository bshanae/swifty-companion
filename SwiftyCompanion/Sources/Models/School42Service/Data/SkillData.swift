import Foundation

extension School42Service {
	public struct SkillData: Decodable {
		public var name: String
		public var level: Float
		
		enum CodingKeys: String, CodingKey {
			case name
			case level
		}
	}
}
