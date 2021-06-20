import Foundation

class UserSummary: ObservableObject {
	public class InterpretationError: Error {}

	private static let currentCursusId = 21
	
	public let imageUrl: String
	public let login: String
	public let level: Double
	public let location: String
	public let wallet: Int
	public let projects: [ProjectSummary]
	public let skills: [SkillSummary]

	public init(from userData: School42Service.UserData) throws {
		self.imageUrl = userData.imageUrl
		self.login = userData.login
		self.wallet = userData.wallet
		
		guard let currentCursus = UserSummary.getCurrentCursus(userData: userData)
		else {
			throw InterpretationError()
		}
		
		self.level = currentCursus.level
		self.location = "-"

		self.projects = userData.projectsUsers
			.filter{ project in project.cursusIds.contains(UserSummary.currentCursusId) }
			.map{ project in ProjectSummary(from: project) }

		self.skills = currentCursus.skills.map{ skillData in SkillSummary(from: skillData) }
	}

	private static func getCurrentCursus(userData: School42Service.UserData) -> School42Service.CursusUserData? {
		return userData.cursusUsers.filter{ $0.cursusId == currentCursusId }.first
	}
}

extension UserSummary {
	public static var testInstance: UserSummary {
		let userDataFile = "testUser.json"
		let userData = FileLoader.loadDecodable(userDataFile) as School42Service.UserData

		do {
			return try UserSummary(from: userData)
		} catch {
			fatalError()
		}
	}
}
