import SwiftUI

extension ProjectPanel {
	struct Project: View {
		public let project: ProjectSummary

		private let nameColor = Color(
			red: 0.85,
			green: 0.85,
			blue: 0.85)

		var body: some View {
			HStack {
				Text(project.name)
					.font(.body)
					.foregroundColor(nameColor)

				Spacer()

				ProjectPanel.ProjectStatus(project: project)
			}
		}
	}
}

struct Project_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			ScrollView {
				VStack(spacing: 10) {
					ForEach(UserSummary.testInstance.projects, id: \.name) {
						ProjectPanel.Project(project: $0)
					}
				}
				.padding()
			}
		}
	}
}
