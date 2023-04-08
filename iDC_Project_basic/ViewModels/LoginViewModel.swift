//
//  LoginViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/26.
//

import Foundation
import FirebaseAuth
import CryptoKit
import SwiftKeychainWrapper
import AuthenticationServices
import Alamofire
import SwiftJWT

class LoginViewModel: NSObject {
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    var currentNonce: String?
    
    func loginWithApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            KeychainWrapper.standard.set(appleIDCredential.user, forKey: "userID")
            
        default:
            break
        }
        
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // nitialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // Firebase Code
            FirebaseAuth.Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if let user = authResult?.user {
                    KeychainWrapper.standard.set(user.uid, forKey: "UID")
                    print("Login Success: ", user.uid, user.email ?? "-")
                    self.onLoginSuccess?()
                } else if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // authorization code
            if let authorizationCode = credential.authorizationCode {
                let code = String(decoding: authorizationCode, as: UTF8.self)
                print("Code - \(code)")
                
                self.getAppleRefreshToken(code: code) { data in
                    UserDefaults.standard.set(data.refreshToken, forKey: "AppleRefreshToken")
                }
            }
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Call the login failure callback with the error message
        self.onLoginFailure?(error.localizedDescription)
    }
    
}

extension LoginViewModel {
    func revokeAppleToken(clientSecret: String, token: String, completionHandler: @escaping () -> Void) {
        let url = "https://appleid.apple.com/auth/revoke"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "client_id": "com.hyeonsu.iDC-Project-basic",
            "client_secret": clientSecret,
            "token": token
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode == 200 {
                print("Delete apple token success")
                completionHandler()
            }
        }
    }
    
    func getAppleRefreshToken(code: String, completionHandler: @escaping (AppleTokenResponse) -> Void) {
        let clientSecret = self.getClientSecret()
        
        let url = "https://appleid.apple.com/auth/token"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "client_id": "com.hyeonsu.iDC-Project-basic",
            "client_secret": "\(clientSecret)",
            "code": code,
            "grant_type": "authorization_code"
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                
                guard let output = try? JSONDecoder().decode(AppleTokenResponse.self, from: data) else {
                    print("Error: JSON Data Parsing failed")
                    return
                }
                
                completionHandler(output)
            case .failure:
                print("Get Apple Token Failed - \(response.error.debugDescription)")
            }
        }
    }
    
    
    func getClientSecret() -> String {
        let privateKeyId = "JW4474FQ22"
        let downloadsFolder = "/Users/pyohyeonsu/desktop/certification"
        let privateKeyPath1 = URL(fileURLWithPath: "/Users/pyohyeonsu/Documents/iOS/iDC_Project_basic/iDC_Project_basic/AuthKey_JW4474FQ22.p8")
        let privateKeyPath = URL(fileURLWithPath: "\(downloadsFolder)/AuthKey_\(privateKeyId).p8")
        let privateKey: Data = try! Data(contentsOf: privateKeyPath1, options: .alwaysMapped)
        let header = Header(kid: privateKeyId)
        
        struct MyClaims: Claims {
            let iss: String
            let iat: Date
            let exp: Date
            let aud: String
            let sub: String
        }
        
        let claims = MyClaims(iss: "MBUQ2HHA5U",
                              iat: Date(),
                              exp: Date(timeIntervalSinceNow: 3600),
                              aud: "https://appleid.apple.com",
                              sub: "com.hyeonsu.iDC-Project-basic" )
        
        var jwt = JWT(header: header, claims: claims)
        let jwtSigner = JWTSigner.es256(privateKey: privateKey)
        let signedJwt = try! jwt.sign(using: jwtSigner)
        
        print("get JWT Success\(signedJwt)")
        UserDefaults.standard.set(signedJwt, forKey: "AppleClientSecret")
        return signedJwt
    }
    
    func Withdraw() {
        if let clientSecret = UserDefaults.standard.string(forKey: "AppleClientSecret"),
           let refreshToken = UserDefaults.standard.string(forKey: "AppleRefreshToken") {
            
            self.revokeAppleToken(clientSecret: clientSecret, token: refreshToken) {
                print("Success Apple Withdraw")
                UserDefaults.standard.set(nil, forKey: "AppleClientSecret")
                UserDefaults.standard.set(nil, forKey: "AppleRefreshToken")
            }
        }
    }
}

struct AppleTokenResponse: Codable {
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
