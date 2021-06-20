import SwiftUI

struct SearchPage: View {
	@EnvironmentObject var school42Service: School42Service
	@Binding public var text: String

	private let userRequested: (String) -> ()
	
	public init(
		text: Binding<String>,
		userRequested: @escaping (String) -> ()
	) {
		self._text = text;
		self.userRequested = userRequested;
	}

	public var body: some View {
		foreground
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
			SearchBar(
				text: $text,
				replaceWithLoader: replaceWithLoader
			) { userName in
				userRequested(userName)
			}
		}
	}
	
	let logoColor = Color(
		red: 0.8,
		green: 0.8,
		blue: 0.8
	)
	
	private var logo: some View {
		Image("logo")
			.resizable()
			.renderingMode(.template)
			.foregroundColor(logoColor)
			.aspectRatio(contentMode: .fit)
			.frame(height: 140)
	}
}

struct SearchPage_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			SearchPage(
				text: .constant("")
			) {
				_ in
			}
			.environmentObject(School42Service())
		}
	}
}
