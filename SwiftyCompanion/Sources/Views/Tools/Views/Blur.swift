import SwiftUI

struct Blur: UIViewRepresentable {
	public var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
	
	public var backgroundColor = UIColor(
		red: 0.4,
		green: 0.4,
		blue: 0.4,
		alpha: 0.1
	)
	
	public func makeUIView(context: Context) -> UIVisualEffectView {
		let effect = UIVisualEffectView(effect: UIBlurEffect(style: style))
		effect.backgroundColor = backgroundColor

		return effect
	}
	
	public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}
}

struct Blur_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Background()
			
			ZStack {
				Blur()
				
				Text("Some text")
					.font(.title)
					.padding()
			}
			.frame(width: 300, height: 300)
		}
	}
}
