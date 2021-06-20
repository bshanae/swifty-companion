import SwiftUI

struct SearchButton: View {
	@Binding var state: State

	public enum State {
		case enabled
		case disabled
		case loading
	}

	private let width: CGFloat
	private let height: CGFloat
	private let pressed: () -> ()
	
	public init(
		width: CGFloat,
		height: CGFloat,
		state: Binding<State>,
		block: @escaping  () -> ()
	) {
		self.width = width
		self.height = height
		self.pressed = block
		self._state = state
	}
	
	private let backgroundColor = Color(
		red: 0.45,
		green: 0.45,
		blue: 0.45,
		opacity: 0.95
	)
	
	public var body: some View {
		currentContent
			.frame(width: width, height: height)
			.background(Rectangle().fill(backgroundColor))
	}
	
	private var currentContent: some View {
		switch state {
		case .enabled:
			return AnyView(enabledView)
			
		case .disabled:
			return AnyView(disabledView)
			
		case .loading:
			return AnyView(loadingView)
		}
	}
	
	private var enabledView: some View {
		Button(action: pressed) {
			Image(systemName: "magnifyingglass")
				.foregroundColor(Color(.white))
		}
	}
	
	private var disabledView: some View {
		Image(systemName: "magnifyingglass")
			.foregroundColor(Color(.gray))
	}
	
	private var loadingView: some View {
		ProgressView()
			.progressViewStyle(CircularProgressViewStyle(tint: Color(.white)))
	}
}

struct SearchButton_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			SearchButton(
				width: 50,
				height: 50,
				state: .constant(.loading)
			) {

			}
		}
	}
}

