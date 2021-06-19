import SwiftUI

struct SearchBar: View {
	private let defaultText = "Type to start"
	
	@Binding private var text: String
	@Binding private var replaceWithLoader: Bool
	
	@State private var buttonState: SearchButton.State
	
	public init(text: Binding<String>, replaceWithLoader: Binding<Bool>) {
		self._text = text
		self._replaceWithLoader = replaceWithLoader
		
		self.buttonState = .disabled
	}
	
	public var body: some View {
		HStack(spacing: 0) {
			textField
			SearchButton(width: 50, height: 50, state: $buttonState)
		}
	}
	
	private let textFieldBackground = Color(
		red: 0.1,
		green: 0.1,
		blue: 0.1,
		opacity: 0.5
	)
	
	private var textField: some View {
		TextField("", text: $text)
			.onChange(of: text, perform: { _ in updateButtonState() })
			.foregroundColor(.white)
			.padding()
			.frame(width: 200, height: 50)
			.background(Rectangle().fill(textFieldBackground))
			
	}
	
	private func updateButtonState() {
		if replaceWithLoader {
			buttonState = .loading
		} else {
			buttonState = text.isEmpty ? .disabled : .enabled
		}
	}
}

struct SearchBar_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			SearchBar(text: .constant(""), replaceWithLoader: .constant(true))
				.padding()
		}
	}
}
