import Foundation

extension School42Service {
	public struct CurcusUserData: Decodable {
		public var level: Float
		public var cursusId: Int
		public var skills: [SkillData]
		
		enum CodingKeys: String, CodingKey {
			case level
			case cursusId = "cursus_id"
			case skills
		}
	}
}
