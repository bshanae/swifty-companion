import SwiftUI

struct SearchPage: View {
	@EnvironmentObject var school42Service: School42Service
	@Binding public var text: String
	
	public var body: some View {
		ZStack {
			background
			foreground
		}
	}
	
	private var background: some View {
		Background()
	}
	
	private var foreground: some View {
		let replaceWithLoader = Binding<Bool>{
			!school42Service.isTokenValid
		}

		return VStack(spacing: 120) {
			logo
			SearchBar(text: $text, replaceWithLoader: replaceWithLoader)
		}
	}
	
	private var logo: some View {
		Image("logo")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(height: 130)
			.font(.system(size: 100))
			.foregroundColor(.white)
	}
}

struct SearchPage_Previews: PreviewProvider {
	static var previews: some View {
		SearchPage(text: .constant("Love Arina"))
			.environmentObject(School42Service())
			.keyboardType(.default)
	}
}
