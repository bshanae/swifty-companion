import SwiftUI

struct SearchPage: View {
	@EnvironmentObject var school42Service: School42Service
	
	private let userRequested: (String) -> ()
	
	public init(userRequested: @escaping (String) -> ()) {
		self.userRequested = userRequested;
	}
	
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
			SearchBar(replaceWithLoader: replaceWithLoader) { userName in
				userRequested(userName)
			}
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
		SearchPage() { _ in }
			.environmentObject(School42Service())
			.keyboardType(.default)
	}
}
