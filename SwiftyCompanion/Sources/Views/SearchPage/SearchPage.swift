import SwiftUI


struct SearchPage: View {
	var body: some View {
		Button("test") {
			School42Service.findUser("bshanae")
		}
	}
	
	init() {
		School42Service.refreshToken()
	}
}

struct SearchPage_Previews: PreviewProvider {
	static var previews: some View {
		SearchPage()
	}
}
