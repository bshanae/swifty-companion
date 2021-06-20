import SwiftUI

public struct ContentView: View {
	private var school42Service: School42Service = School42Service()
	
	@State private var user: UserSummary?
	@State private var text: String = ""
	
	public var body: some View {
		ZStack {
			Background()
			searchPage
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
