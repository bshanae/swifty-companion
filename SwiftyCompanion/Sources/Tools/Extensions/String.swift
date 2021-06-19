extension String {
	var isAlpha: Bool {
		return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
	}
}
