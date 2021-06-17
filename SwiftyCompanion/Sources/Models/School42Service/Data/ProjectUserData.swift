import Foundation

extension School42Service {
	public struct ProjectUserData: Decodable {
		public var finalMark: Int
		public var status: String
		public var isValidated: String
		public var project: ProjectData
		
		enum CodingKeys: String, CodingKey {
			case finalMark = "final_mark"
			case status
			case isValidated = "validated?"
			case project
		}
	}
}

