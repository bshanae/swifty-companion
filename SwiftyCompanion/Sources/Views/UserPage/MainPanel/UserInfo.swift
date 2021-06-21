import SwiftUI

extension MainPanel {
	struct UserInfo: View {
		@EnvironmentObject private var userData: UserSummary
		
		public let spacing: CGFloat
		
		var body: some View {
			HStack(spacing: 8) {
				VStack(alignment: .trailing, spacing: spacing) {
					UserInfo.hintText("Level")
					UserInfo.hintText("Location")
					UserInfo.hintText("Wallet")
				}
				.frame(width: 80, alignment: .trailing)

				VStack(alignment: .leading, spacing: spacing) {
					UserInfo.mainText("\(userData.level)")
					UserInfo.mainText(userData.location ?? "-")
					UserInfo.mainText("\(userData.wallet) ₳")
				}
				.frame(width: 80, alignment: .leading)
			}
		}

		private static let hintColor = Color(
			red: 0.7,
			green: 0.7,
			blue: 0.7)
		
		private static func hintText(_ text: String) -> some View {
			Text(text).foregroundColor(hintColor)
		}
		
		private static func mainText(_ text: String) -> some View {
			Text(text).foregroundColor(.white)
		}
	}
}

struct MainPanel_Row_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			MainPanel.UserInfo(spacing: 10)
				.background(Color.black)
				.environmentObject(UserSummary.testInstance)
		}
	}
}
