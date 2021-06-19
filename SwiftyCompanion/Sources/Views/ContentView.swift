import SwiftUI

struct ContentView: View {
	@StateObject private var school42Service: School42Service = School42Service()
	@State private var text: String = ""
	
    var body: some View {
		SearchPage(text: $text)
			.environmentObject(school42Service)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
