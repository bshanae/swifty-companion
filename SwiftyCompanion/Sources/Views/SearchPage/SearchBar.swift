import SwiftUI

struct SearchBar: View {
	@State private var text: String = ""
	@Binding private var replaceWithLoader: Bool

	private let searchButtonPressed: (String) -> ()
	
	public init(replaceWithLoader: Binding<Bool>, block: @escaping (String) -> ()) {
		self.searchButtonPressed = block
		self._replaceWithLoader = replaceWithLoader
	}
	
	public var body: some View {
		let buttonState = Binding<SearchButton.State>{
			if replaceWithLoader {
				return .loading
			} else {
				return text.isEmpty ? .disabled : .enabled
			}
		}
		
		return HStack(spacing: 0) {
			textField
			SearchButton(width: 50, height: 50, state: buttonState) {
				searchButtonPressed(text)
			}
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
			.foregroundColor(.white)
			.padding()
			.frame(width: 200, height: 50)
			.background(Rectangle().fill(textFieldBackground))
			.disableAutocorrection(true)
			.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
		
	}
}

struct SearchBar_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			SearchBar(replaceWithLoader: .constant(true)) { _ in }
				.padding()
		}
	}
}
