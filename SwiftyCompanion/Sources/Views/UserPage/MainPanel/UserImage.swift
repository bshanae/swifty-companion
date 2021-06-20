import SwiftUI
import SDWebImageSwiftUI

extension MainPanel {
	struct UserImage: View {
		@EnvironmentObject private var userData: UserSummary

		var body: some View {
			WebImage(url: URL(string: userData.imageUrl))
				.placeholder{ ProgressView() }
				.resizable()
				.clipShape(Circle())
				.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
		}
	}
}

struct UserImage_Previews: PreviewProvider {
	static var previews: some View {
		MainPanel.UserImage()
			.environmentObject(UserSummary.testInstance)
	}
}
