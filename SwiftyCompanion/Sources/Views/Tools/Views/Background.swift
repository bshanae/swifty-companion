import SwiftUI

struct Background: View {
	var body: some View {
		GeometryReader { geometry in
			Image("background")
				.resizable()
				.scaledToFill()
				.frame(width: geometry.size.width) // makes image static
				.edgesIgnoringSafeArea(.all)
		}
	}
}

struct Background_Previews: PreviewProvider {
	static var previews: some View {
		Background()
	}
}
