import Foundation

class School42Service: ObservableObject{
	private let updateInterval = 1.0
	
	private let token: TokenWrapper
	private weak var timer: Timer?
	
	@Published var isTokenValid: Bool = false
	
	public init() {
		token = TokenWrapper()
		timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in self?.update() }

		School42Service.requestToken(on: token, callOnResult: onTokenRequestResult)
	}

	deinit {
		timer?.invalidate()
	}

	public func requestUser(_ user: String) {
		if token.isValid {
			School42Service.requestUser(user, using: token)
		}
	}

	private func update() {
		if token.isSet && token.isExpired {
			token.unset()
			isTokenValid = false

			School42Service.requestToken(on: token, callOnResult: onTokenRequestResult)
		}
	}

	private func onTokenRequestResult(result: Bool) {
		isTokenValid = result
	}
}
