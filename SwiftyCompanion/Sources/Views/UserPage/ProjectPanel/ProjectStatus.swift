import SwiftUI

extension ProjectPanel {
	struct ProjectStatus: View {
		public let project: ProjectSummary
		
		var body: some View {
			let color = color
			let text = text
			
			return Text(text)
				.font(.caption)
				.foregroundColor(color)
				.padding(.vertical, 2)
				.padding(.horizontal, 6)
				.background(
					RoundedRectangle(cornerRadius: 5)
						.stroke(color, lineWidth: 2)
				)
		}
		
		private var text: String {
			switch project.status {
			case .success:
				return project.mark != nil ? String(project.mark!) : "?"
				
			default:
				return project.status.rawValue
			}
		}
		
		private var color: Color {
			switch project.status {
			case .fail:
				return .red
				
			case .success:
				return .green
				
			default:
				return .white
			}
		}
	}
}

struct ProjectStatus_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			ScrollView {
				VStack {
					ForEach(UserSummary.testInstance.projects, id: \.name) {
						ProjectPanel.ProjectStatus(project: $0)
					}
				}
			}
		}
	}
}
