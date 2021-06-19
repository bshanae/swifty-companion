import SwiftUI

struct ContentView: View {
	@State var text: String = ""
	
    var body: some View {
		SearchPage(text: $text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
