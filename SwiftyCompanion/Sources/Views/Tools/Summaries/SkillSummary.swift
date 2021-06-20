import Foundation

import Foundation

class SkillSummary: ObservableObject {
	public let name: String
	public let level: Double
	
	public init(from skillData: School42Service.SkillData) {
		self.name = SkillSummary.extractName(from: skillData)
		self.level = skillData.level
	}

	private static func extractName(from skillData: School42Service.SkillData) -> String {
		let lengthLimit = 25
		let rawName = skillData.name

		if rawName.count > lengthLimit {
			return rawName.prefix(lengthLimit - 3) + "..."
		} else {
			return rawName
		}
	}
}
