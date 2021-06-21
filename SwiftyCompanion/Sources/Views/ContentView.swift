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
	
	@StateObject private var page: Page = .first()
	@State private var pageTypes = [PageType.searchPage]
	
	public var body: some View {
		ZStack {
			Background()
			
			Pager(
				page: page,
				data: pageTypes,
				content: buildPage
			)
			.allowsDragging(user != nil)
			.expandPageToEdges()
			.swipeInteractionArea(.allAvailable)
			.onPageChanged{ pageIndex in
				withAnimation { page.index += pageIndex }
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
	
	private func onUserRequested(_ userName: String) {
		user = nil
		
		school42Service.requestUser(userName) { (user, error) in
			if user != nil {
				print("user found!")
				
				do {
					self.user = try UserSummary(from: user!)
					
					self.pageTypes.removeAll(where: { $0 == .userPage })
					self.pageTypes.append(.userPage)
					
					// This is hack
					DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
						withAnimation {
							self.page.update(Page.Update.new(index: 1))
						}
					}
					
				} catch {
					print("Can't collect user summary")
				}
				
			} else {
				print("user not found : \(error ?? "?")")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
