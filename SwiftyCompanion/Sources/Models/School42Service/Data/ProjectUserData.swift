import Foundation

extension School42Service {
	public struct ProjectUserData: Decodable {
		public var finalMark: Int?
		public var status: String
		public var isValidated: Bool?
		public var project: ProjectData
		public var cursusIds: [Int]
		
		enum CodingKeys: String, CodingKey {
			case finalMark = "final_mark"
			case status
			case isValidated = "validated?"
			case project
			case cursusIds = "cursus_ids"
		}
	}
}

