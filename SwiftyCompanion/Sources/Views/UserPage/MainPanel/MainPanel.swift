import SwiftUI

struct MainPanel: View {
	@EnvironmentObject private var userData: UserSummary

	public var body: some View {
		VStack(spacing: UserPageConfiguration.panelSpacing) {
			Spacer().frame(height: UserPageConfiguration.panelPadding)
			
			MainPanel.UserImage()
			MainPanel.UserLogin()
			MainPanel.UserInfo(spacing: UserPageConfiguration.panelSpacing)

			Spacer().frame(height: UserPageConfiguration.panelPadding)
		}
		.frame(width: UserPageConfiguration.panelWidth)
		.background(Blur(backgroundColor: UserPageConfiguration.blurBackgroundColor))
		.cornerRadius(UserPageConfiguration.panelCornerRadius)
	}
}

struct MainPanel_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Background()
			MainPanel()
				.environmentObject(UserSummary.testInstance)
		}
    }
}
