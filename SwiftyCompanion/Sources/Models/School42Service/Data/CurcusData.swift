import Foundation

extension School42Service {
	public struct CurcusData: Decodable {
		public var level: Float
		public var curcusId: Int
		public var skills: [SkillData]
		
		enum CodingKeys: String, CodingKey {
			case level
			case curcusId = "curcus_id"
			case skills
		}
	}
}
