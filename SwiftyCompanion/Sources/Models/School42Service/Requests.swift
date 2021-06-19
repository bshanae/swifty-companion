import Foundation
import Alamofire

extension School42Service {
	public typealias TokenRequestCallback = (_ result: Bool, _ error: String?) -> ()
	private static var isRequestingToken: Bool = false
	
	public static func requestToken(
		on tokenWrapper: TokenWrapper,
		callOnResult resultCallback: TokenRequestCallback? = nil
	) {
		if isRequestingToken {
			print("Token is already requested, waiting for response")
			return
		}
		
		print("Requesting new token")
		isRequestingToken = true;
		
		let url = "https://api.intra.42.fr/oauth/token"
		
		let params = ["grant_type": "client_credentials",
					  "client_id": "1cdd3068e50c016bcefebbf1c43b3bf150e86a94862ed4a602470de5253c1134",
					  "client_secret": "64ec855a0d435a7e715e03a3ffb353ce35035b2d7b7a359690334d48c090e62f"]
		
		AF.request(url, method: .post, parameters: params)
			.validate()
			.responseDecodable(of: School42Service.AuthData.self) { (response) in
				guard let authData = response.value else {
					let errorDescription = String(describing: response.error)
					print("[School42Service] Request token error : \(errorDescription)")
					
					isRequestingToken = false
					resultCallback?(false, errorDescription)
					return
				}
				
				#if DEBUG
				do { sleep(2) }
				tokenWrapper.set(token: authData.accessToken, forSeconds: 30)
				#else
				tokenWrapper.set(token: authData.accessToken, forSeconds: authData.expiresIn)
				#endif
				
				isRequestingToken = false
				resultCallback?(true, nil)
				
				print("[School42Service] Request token success")
			}
	}

	public typealias UserRequestCallback = (_ user: UserData?, _ error: String?) -> ()
	private static var isRequestingUser: Bool = false
	
	public static func requestUser(
		_ user: String,
		using tokenWrapper: TokenWrapper,
		callOnResult resultCallback: @escaping UserRequestCallback
	) {
		if !tokenWrapper.isValid {
			print("[School42Service] Token wrapper doesn't has a valid token")
			return
		}

		if isRequestingUser {
			resultCallback(nil, "Previous request is not finished")
			print("[School42Service] Already requesting a user")
			return
		}
		
		print("[School42Service] Requesting user")
		isRequestingUser = true
		
		let url = "https://api.intra.42.fr/v2/users/\(user)"
		let headers = HTTPHeaders(["Authorization": "Bearer \(tokenWrapper.value!)"])
		
		AF.request(url, method: .get, headers: headers)
			.validate()
			.responseDecodable(of: School42Service.UserData.self) { (response) in
				guard let userData = response.value else {
					let errorDescription = String(describing: response.error)
					print("[School42Service] Request user error : \(errorDescription)")

					isRequestingUser = false
					resultCallback(nil, errorDescription)
					return
				}

				print("[School42Service] Request user success")
				
				isRequestingUser = false
				resultCallback(userData, nil)
			}
	}
}
