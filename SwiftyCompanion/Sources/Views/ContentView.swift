import SwiftUI

struct ContentView: View {
	@State private var searchText = ""

    var body: some View {
		SearchBar(text: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
