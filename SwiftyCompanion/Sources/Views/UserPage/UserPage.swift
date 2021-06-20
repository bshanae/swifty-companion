import SwiftUI

struct UserPage: View {
	@EnvironmentObject private var userData: UserSummary

	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 25) {
				MainPanel()
				SkillPanel()
				ProjectPanel()
			}
		}
	}
}

struct UserPage_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			UserPage()
				.environmentObject(UserSummary.testInstance)
		}
	}
}
