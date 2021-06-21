import SwiftUI
import SwiftUIPager

public struct ContentView: View {
	private enum PageType : Int, Identifiable {
		public var id: RawValue {
			rawValue
		}
		
		case searchPage
		case userPage
	}
	
	private var school42Service: School42Service = School42Service()
	
	@State private var user: UserSummary?
	@State private var text: String = ""
	@State private var error: String = ""
	
	@StateObject private var page: Page = .first()
	@State private var pageTypes = [PageType.searchPage]
	
	public var body: some View {
		ZStack {
			Background().zIndex(0)
			
			Pager(
				page: page,
				data: pageTypes,
				content: buildPage
			)
			.allowsDragging(user != nil)
			.expandPageToEdges()
			.swipeInteractionArea(.allAvailable)
			.disabled(!error.isEmpty)
			.zIndex(1)
			
			if !error.isEmpty {
				errorMessage.zIndex(2)
			}
		}
	}
	
	private func buildPage(of pageType: PageType) -> some View {
		if pageType == .searchPage {
			return AnyView(searchPage)
		} else {
			// 'else' is needed for it to compile
			return AnyView(userPage)
		}
	}
	
	private var searchPage: some View {
		SearchPage(text: $text) { userName in onUserRequested(userName) }
			.environmentObject(school42Service)
	}
	
	private var userPage: some View {
		if user == nil {
			return AnyView(
				Text("You shoulnd't see this..")
					.font(.title2)
					.foregroundColor(.white)
			)
		}
		
		return AnyView(
			UserPage()
				.environmentObject(user!)
		)
	}
	
	private var errorMessage: some View {
		ZStack {
			Rectangle()
				.foregroundColor(Color(white: 0, opacity: 0))
				.background(Blur(style: .systemUltraThinMaterial))
				.frame(width: 200, height: 200)
				.cornerRadius(5)
			
			Text(error)
				.font(.title2)
				.foregroundColor(.white)
		}
	}
	
	private func onUserRequested(_ userName: String) {
		user = nil
		
		school42Service.requestUser(userName) { (user, error) in
			if user != nil {
				do {
					let userSymmary = try UserSummary(from: user!)
					onUserRequestSuccess(user: userSymmary)
				} catch {
					onUserRequestFail(error: "Can't parse user info")
				}
			} else {
				onUserRequestFail(error: error ?? "Unknown error")
			}
		}
	}
	
	private func onUserRequestSuccess(user: UserSummary) {
		self.user = user
		
		self.pageTypes.removeAll(where: { $0 == .userPage })
		self.pageTypes.append(.userPage)
		
		// This is hack
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
			withAnimation {
				self.page.update(Page.Update.new(index: 1))
			}
		}
	}
	
	private func onUserRequestFail(error: String) {
		self.error = error
		
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
			withAnimation {
				self.error = ""
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
