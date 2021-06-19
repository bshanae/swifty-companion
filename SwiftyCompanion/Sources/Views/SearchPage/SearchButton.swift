import SwiftUI

struct SearchButton: View {
	private let width: CGFloat
	private let height: CGFloat

	public enum State {
		case enabled
		case disabled
		case loading
	}
	
	@Binding var state: State
	
	public init(width: CGFloat, height: CGFloat, state: Binding<State>) {
		self.width = width
		self.height = height
		self._state = state
	}
	
	private let backgroundColor = Color(
		red: 0.1,
		green: 0.1,
		blue: 0.1,
		opacity: 0.9
	)
	
	public var body: some View {
		currentContent
			.frame(width: width, height: height)
			.background(Rectangle().fill(backgroundColor))
	}
	
	private var currentContent: some View {
		switch state {
			case .enabled:
				return AnyView(activeMagnifyingGlass)

			case .disabled:
				return AnyView(inactivedMagnifyingGlass)

			case .loading:
				return AnyView(progressView)
		}
	}
	
	private var activeMagnifyingGlass: some View {
		Image(systemName: "magnifyingglass")
			.foregroundColor(Color(.white))
	}

	private var inactivedMagnifyingGlass: some View {
		Image(systemName: "magnifyingglass")
			.foregroundColor(Color(.gray))
	}
	
	private var progressView: some View {
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
			)
		}
	}
}

