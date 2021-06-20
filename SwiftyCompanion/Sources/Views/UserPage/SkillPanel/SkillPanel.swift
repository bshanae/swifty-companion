import SwiftUI

struct SkillPanel: View {
	@EnvironmentObject private var userData: UserSummary
	
	var body: some View {
		VStack(spacing: 0) {
			header
			Spacer().frame(height: 8)
			projects
			Spacer().frame(height: 14)
		}
		.frame(width: UserPageConfiguration.panelWidth)
		.background(Blur(backgroundColor: UserPageConfiguration.blurBackgroundColor))
		.cornerRadius(UserPageConfiguration.panelCornerRadius)
	}
	
	private var header: some View {
		ZStack {
			let fillColor = Color(
				red: 0,
				green: 0,
				blue: 0,
				opacity: 0.2
			)
			
			Rectangle()
				.fill(fillColor)
			
			Text("Skills")
				.font(.footnote)
				.foregroundColor(.gray)
		}
		.frame(height: 12)
	}
	
	private var projects: some View {
		
		VStack(spacing: 10) {
			ForEach(userData.skills, id: \.name) {
				Skill(skill: $0)
			}
		}
		.padding(.horizontal, 18)
	}
}

struct SkillPanel_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			ScrollView(showsIndicators: false) {
				SkillPanel()
					.environmentObject(UserSummary.testInstance)
			}
		}
	}
}
