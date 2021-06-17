import Foundation

extension School42Service {
	public struct TokenWrapper {
		public static func wrap(_ token: String, forSeconds durationInSeconds: Int) -> TokenWrapper {
			return TokenWrapper(
				token: token,
				durationInSeconds: durationInSeconds
			)
		}

		public let token: String
		private let expirationTime: Date

		public var value: String? {
			isExpired ? nil : token
		}

		public var isExpired: Bool {
			true
		}

		private init(token: String, durationInSeconds: Int) {
			self.token = token
			self.expirationTime = TokenWrapper.getExpirationTime(durationInSeconds: durationInSeconds)
		}
		
		private static func getExpirationTime(durationInSeconds: Int) -> Date {
			let duration = DateComponents(second: durationInSeconds)
			return Calendar.current.date(byAdding: duration, to: Date())!
		}
	}
}
