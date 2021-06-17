import SwiftUI

struct SearchBar: View {
	private let defaultText = "Type to start"
	
	@Binding public var text: String
	@State private var isEditing: Bool = false
	
	public var body: some View {
		HStack(spacing: 0) {
			magnifyingGlassImage

			textField
			
			if isEditing {
				cancelButton
			}
		}
		.background(Capsule().fill(Color(.systemGray6)))
	}
	
	private var magnifyingGlassImage: some View {
		Image(systemName: "magnifyingglass")
			.foregroundColor(.gray)
			.padding(.leading, 8)
	}
	
	private var textField: some View {
		TextField(defaultText, text: $text)
			.padding(5)
			.onTapGesture {
				self.isEditing = true
			}
			.frame(minWidth: 0, maxWidth: .infinity)
	}
	
	private var cancelButton: some View {
		Button(action: {
			self.text = ""
		}) {
			Image(systemName: "multiply.circle.fill")
				.foregroundColor(.gray)
				.padding(.trailing, 8)
		}
	}
}

struct SearchBar_Previews: PreviewProvider {
	static var previews: some View {
		SearchBar(text: .constant("Love Arina"))
			.padding()
	}
}
