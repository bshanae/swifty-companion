import SwiftUI

extension SkillPanel {
	struct Skill: View {
		public let skill: SkillSummary

		private let nameColor = Color(
			red: 0.85,
			green: 0.85,
			blue: 0.85)

		var body: some View {
			HStack {
				Text(skill.name)
					.font(.body)
					.foregroundColor(nameColor)

				Spacer()

				Text(String(skill.level))
					.font(.body)
					.foregroundColor(.white)
			}
		}
	}
}

struct Skill_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			ScrollView {
				VStack(spacing: 10) {
					ForEach(UserSummary.testInstance.skills, id: \.name) {
						SkillPanel.Skill(skill: $0)
					}
				}
				.padding()
			}
		}
	}
}
