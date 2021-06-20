import SwiftUI

struct SearchBar: View {
	@Binding private var text: String
	@Binding private var replaceWithLoader: Bool
	
	private let userRequested: (String) -> ()
	
	public init(
		text: Binding<String>,
		replaceWithLoader: Binding<Bool>,
		block: @escaping (String) -> ()
	) {
		self._text = text
		self.userRequested = block
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
				userRequested(text)
			}
		}
		.cornerRadius(2)
	}
	
	private let blurBackgroundColor = UIColor(
		red: 0.1,
		green: 0.1,
		blue: 0.1,
		alpha: 0.1
	)
	
	private var textField: some View {
		TextField("", text: $text, onCommit: { userRequested(text) })
			.disableAutocorrection(true)
			.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
			.accentColor(.white)
			.foregroundColor(.white)
			.padding()
			.frame(width: 180, height: 50)
			.background(Blur(backgroundColor: blurBackgroundColor))
	}
}

struct SearchBar_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			SearchBar(
				text: .constant(""),
				replaceWithLoader: .constant(true)
			) {
				_ in
				
			}.padding()
		}
	}
}
