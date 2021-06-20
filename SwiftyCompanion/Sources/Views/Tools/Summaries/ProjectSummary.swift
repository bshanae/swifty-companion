import Foundation

import Foundation

class ProjectSummary: ObservableObject {
	public enum Status: String {
		case unknown = "Unknown"
		case registered = "Registered"
		case searchingGroup = "Searching a group"
		case inProgress = "In progress"
		case fail = "Fail"
		case success = "Success"
	}

	public let name: String
	public let status: Status
	public let mark: Int?
	
	public init(from projectData: School42Service.ProjectUserData) {
		self.name = ProjectSummary.extractProjectName(from: projectData)
		self.status = ProjectSummary.extractProjectStatus(from: projectData)
		self.mark = projectData.finalMark
	}

	private static func extractProjectName(from projectData: School42Service.ProjectUserData) -> String {
		let lengthLimit = 18
		let rawName = projectData.project.name

		if rawName.count > lengthLimit {
			return rawName.prefix(lengthLimit - 3) + "..."
		} else {
			return rawName
		}
	}

	private static func extractProjectStatus(from projectData: School42Service.ProjectUserData) -> Status {
		switch projectData.status {
		case "registered":
			return .registered

		case "searching_a_group":
			return .searchingGroup

		case "in_progress":
			return .inProgress

		case "finished":
			if (projectData.finalMark ?? 0) != 0 {
				return .success
			} else {
				return .fail
			}

		default:
			return .unknown
		}
	}
}
