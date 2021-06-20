import SwiftUI

extension MainPanel {
	struct UserLogin: View {
		@EnvironmentObject private var userData: UserSummary
		
		var body: some View {
			Text(userData.login)
				.font(.title2)
				.fontWeight(.bold)
				.foregroundColor(.white)
		}
	}
}

struct UserLogin_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			MainPanel.UserLogin()
				.environmentObject(UserSummary.testInstance)
		}
	}
}
