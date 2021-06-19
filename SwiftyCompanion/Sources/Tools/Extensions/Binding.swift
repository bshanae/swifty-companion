import SwiftUI

extension Binding {
	public init(block: @escaping () -> Value) {
		self.init(
			get: block,
			set: { _ in }
		)
	}
}

