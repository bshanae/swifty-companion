import SwiftUI

struct ContentView: View {
	@StateObject private var school42Service: School42Service = School42Service()
	@State private var text: String = ""
	
	var body: some View {
		SearchPage() { userName in onUserRequested(userName) }
			.environmentObject(school42Service)
	}
	
	private func onUserRequested(_ userName: String) {
		school42Service.requestUser(userName) { (user, error) in
			if user != nil {
				print("user found!")
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
