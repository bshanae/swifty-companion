import Foundation
import Alamofire

struct School42Service {
	private static var tokenWrapper: TokenWrapper?
	private static var isRefreshingToken: Bool = false
	
	public static func refreshToken() {
		if isRefreshingToken {
			print("Token is already requested, waiting for response")
			return
		}
		
		print("Requesting new token")

		tokenWrapper = nil
		isRefreshingToken = true;
		
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
					
					isRefreshingToken = false
					return
				}
				
				print("[School42Service] Request token success")
				tokenWrapper = TokenWrapper.wrap(authData.accessToken, forSeconds: authData.expiresIn)
				isRefreshingToken = false
			}
	}
	
	public static func findUser(_ user: String) {
		if tokenWrapper?.isExpired != false {
			print("[School42Service] Token is not set, can't find user")
			return
		}

		print("[School42Service] Requesting user")

		let url = "https://api.intra.42.fr/v2/users/\(user)"
		let headers = HTTPHeaders(["Authorization": "Bearer \(tokenWrapper!.token)"])

		AF.request(url, method: .get, headers: headers)
			.validate()
			.responseDecodable(of: School42Service.UserData.self) { (response) in
				guard let userData = response.value else {
					let errorDescription = String(describing: response.error)
					print("[School42Service] Request user error : \(errorDescription)")
					return
				}
				
				print("[School42Service] Request user success")
				print(userData)
			}
	}
}
