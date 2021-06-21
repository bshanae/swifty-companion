import Foundation

class School42Service: ObservableObject {
	private let updateInterval = 1.0
	
	private let token: TokenWrapper
	private weak var timer: Timer?
	private var userRequestCallback: UserRequestCallback?

	@Published var isTokenValid: Bool = false
	@Published var isRequestingUser: Bool = false
	
	public init() {
		token = TokenWrapper()
		timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in self?.update() }

		School42Service.requestToken(on: token, callOnResult: onTokenRequestResult)
	}

	deinit {
		timer?.invalidate()
	}

	public func requestUser(
		_ user: String,
		callOnResult userRequestCallback: @escaping UserRequestCallback
	) {
		if !user.isAlpha {
			userRequestCallback(nil, "Invalid user name")
			return
		}

		if token.isValid {
			isRequestingUser = true
			School42Service.requestUser(
				user,
				using: token,
				callOnResult: { (user, error) in
					self.isRequestingUser = false
					userRequestCallback(user, error)
				}
			)
		}
	}

	private func update() {
		if token.isSet && token.isExpired {
			token.unset()
			isTokenValid = false

			School42Service.requestToken(on: token, callOnResult: onTokenRequestResult)
		}
	}

	private func onTokenRequestResult(result: Bool, error: String?) {
		isTokenValid = result
	}
}
