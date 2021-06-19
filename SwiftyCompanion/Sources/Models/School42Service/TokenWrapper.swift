import Foundation

extension School42Service {
	public class TokenWrapper {
		public func set(token: String, forSeconds durationInSeconds: Int) {
			internalValue = token
			expirationTime = TokenWrapper.getExpirationTime(durationInSeconds: durationInSeconds)
		}
		
		public func unset() {
			internalValue = nil
			expirationTime = nil
		}
		
		public var internalValue: String?
		private var expirationTime: Date?
		
		public var value: String? {
			isValid ? internalValue : nil
		}
		
		public var isValid: Bool {
			isSet && !isExpired
		}
		
		public var isSet: Bool {
			internalValue != nil && expirationTime != nil
		}
		
		public var isExpired: Bool {
			expirationTime != nil ? Date() >= expirationTime! : false
		}
		
		private static func getExpirationTime(durationInSeconds: Int) -> Date {
			let duration = DateComponents(second: durationInSeconds)
			return Calendar.current.date(byAdding: duration, to: Date())!
		}
	}
}
