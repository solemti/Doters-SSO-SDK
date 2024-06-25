//
//  AuthSSODoters.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation
import AuthenticationServices

public class AuthSSODoters : NSObject{

    var shimController = ShimViewController()
    var scheme=""
    var url=""
    var APIurl=""
    var language=""
    var clientId=""
    var clientSecret=""
    var state=""
    var loginData: LoginData
    var userInfo: UserInfoData
    var introspection: IntrospectionData
    var resultCodeData: ResultCodeData
    
    public override init() {
        loginData = LoginData()
        userInfo = UserInfoData()
        introspection = IntrospectionData()
        resultCodeData = ResultCodeData()
    }
    
    
    public func setScheme(sheme:String){
        self.scheme = sheme
    }
    
    public func setAPIUrl(APIurl:String){
        self.APIurl = APIurl
    }
    
    public func setUrl(url:String){
        self.url = url
    }
    
    public func setLanguage(language:String){
        self.language = language
    }
    
    public func setClientId(clientId:String){
        self.clientId = clientId
    }
    
    public func setClientSecret(clientSecret:String){
        self.clientSecret = clientSecret
    }
    
    public func setState(state:String){
        self.state = state
    }

    public func signIn(completion: @escaping (LoginData, Error?) -> ()) {
        let authUrlString = "\(url)?clientId=\(clientId)&clientSecret=\(clientSecret)&language=\(language)&redirectUri=\(scheme)://login&state=\(state)";
        guard let urlAuth = URL(string: authUrlString) else { return }
        
        let session = ASWebAuthenticationSession(
            url: urlAuth,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                guard error == nil, let successURL = callback else { return }
                self.loginData = LoginData()
                self.getLogin(data: successURL.absoluteString)

                var signInError: Error? = error
                
                if !self.loginData.error.isEmpty {
                    signInError = NSError(domain: "SignInErrorDomain", code: SignInError.unknownError.rawValue, userInfo: [NSLocalizedDescriptionKey: self.loginData.error])
                }else if(self.loginData.accessToken.isEmpty){
                    signInError = NSError(domain:  "SignInErrorDomain", code: SignInError.processCanceled.rawValue, userInfo: [NSLocalizedDescriptionKey: SignInError.processCanceled.localizedDescription])
                }
               
               completion(self.loginData, signInError)
        })
        
        self.start(session: session)
        
    }
    
    public func signUp() {
        let authUrlString = "\(url)?clientId=\(clientId)&clientSecret=\(clientSecret)&language=\(language)&redirectUri=\(scheme)://signup&go_to_page=signup&state=\(state)";
        guard let urlAuth = URL(string: authUrlString) else { return }
        
        let session = ASWebAuthenticationSession(
            url: urlAuth,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
            })
        
        self.start(session: session)
        
    }
    
    public func editProfile(completion: @escaping (String, Error?) -> ()) {
        let authUrlString = "\(url)/profile/edit?redirectUri=\(scheme)://edit";
       
        guard let urlAuth = URL(string: authUrlString) else { return }
        
        let session = ASWebAuthenticationSession(
            url: urlAuth,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                completion("Process editProfile finished",error)
            })
        
        self.start(session: session)
    }

    public func logOut(completion: @escaping (String, Error?) -> ()) {
        
        let authUrlString = "\(url)/logout?post_logout_redirect_uri=\(scheme)://logout&client_id=\(clientId)";
        guard let urlAuth = URL(string: authUrlString) else { return }
       
        let session = ASWebAuthenticationSession(
            url: urlAuth,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                completion("succesLogout",error)
        })
        
        self.start(session: session)
    }
    
    public func deleteAccount(completion: @escaping (ResultCodeData, Error?) -> ()) {
        let authUrlString = "\(url)/user/cancel?redirectUri=\(scheme)://cancel&clientId=\(clientId)&clientSecret=\(clientSecret)&originApp=true";
        guard let urlAuth = URL(string: authUrlString) else { return }
        
        let session = ASWebAuthenticationSession(
            url: urlAuth,
            callbackURLScheme: scheme,
            completionHandler: { callback, error in
                guard error == nil, let successURL = callback else {
                    self.resultCodeData = ResultCodeData()
                    self.resultCodeData.resultCode = "PROCESS_CANCELED"
                    completion(self.resultCodeData,error)
                    return
                }
                self.resultCodeData = ResultCodeData()
                self.getResultCode(data: successURL.absoluteString)
                completion(self.resultCodeData,error)
        })
        
        self.start(session: session)
        
    }
    
    private func start(session:ASWebAuthenticationSession){
        session.presentationContextProvider = shimController
        session.start()
    }
    
    public func refreshToken(token:String, completion: @escaping (LoginData, Error?) -> ()) {
        if(token.isEmpty){
            loginData.errorDescription=" missing required parameter 'refresh_token' "
            loginData.error="invalid_request"
            completion(self.loginData,nil)
            return
        }
        let requestHeaders: [String:String] = ["Authorization": "Basic \(authorization())",
            "X-Channel": "ios",
            "Content-Type": "application/x-www-form-urlencoded"]
        var requestBody=URLComponents()
        
        requestBody.queryItems = [URLQueryItem(name: "refresh_token", value: token),
                                  URLQueryItem(name: "grant_type", value: "refresh_token")]
        
        var request = URLRequest(url: URL(string:"\(APIurl)/token")!)
        request.httpMethod="POST"
        request.allHTTPHeaderFields=requestHeaders
        request.httpBody=requestBody.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            self.loginData = LoginData()
            self.getRefreshToken(data: data)
            completion(self.loginData,error)
        }).resume()
        
    }
    
    public func tokenIntrospection(accessToken:String, completion: @escaping (IntrospectionData, Error?) -> ()) {
        
        if(accessToken.isEmpty){
            introspection.errorDescription=" missing required parameter 'access_token' "
            introspection.error="invalid_request"
            completion(self.introspection,nil)
            return
        }
        let requestHeaders: [String:String] = ["Authorization": "Basic \(authorization())",
                                               "X-Channel": "ios",
                                               "Content-Type": "application/x-www-form-urlencoded"]
        var requestBody=URLComponents()
        
        requestBody.queryItems = [URLQueryItem(name: "token", value: accessToken),
                                  URLQueryItem(name: "token_type_hint", value: "access_token")]
        
        var request = URLRequest(url: URL(string:"\(APIurl)/token/introspection")!)
        request.httpMethod="POST"
        request.allHTTPHeaderFields=requestHeaders
        request.httpBody=requestBody.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            self.introspection = IntrospectionData()
            self.getTokenIntrospection(data: data)
            completion(self.introspection ,error)

        }).resume()
        
    }
    
    public func userInfo(accessToken:String, completion: @escaping (UserInfoData, Error?) -> ()) {
        if(accessToken.isEmpty){
            userInfo.errorDescription=" missing required parameter 'access_token' "
            userInfo.error="invalid_request"
            completion(self.userInfo,nil)
            return
        }
        
        let requestHeaders: [String:String] = ["Authorization": "Bearer \(accessToken)",
                                               "X-Channel": "ios",
                                               "Content-Type": "application/json"]
        
        var request = URLRequest(url: URL(string:"\(APIurl)/user")!)
        request.httpMethod="GET"
        request.allHTTPHeaderFields=requestHeaders
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            self.userInfo = UserInfoData()
            self.getUserInfo(data: data)
            completion(self.userInfo,error)
        
        }).resume()
        
    }
    
     func  authorization() -> String{
        let loginString = String(format: "%@:%@", self.clientId, self.clientSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
    
    public func getLogin(data:String){
        if(URLComponents(string: (data))!.queryItems?.isEmpty ?? true ){
            return
        }
        
        if let access_token = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "access_token" }).first {
            loginData.accessToken = access_token.value!
        }
        
        if let expires_in = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "expires_in" }).first {
            loginData.expiresIn =  Int(expires_in.value!) ?? 0
        }
        
        if let id_token = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "id_token" }).first {
            loginData.idToken = id_token.value!
        }
        
        if let scope = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "scope" }).first {
            loginData.scope = scope.value!
        }
        
        if let token_type = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "token_type" }).first {
            loginData.tokenType = token_type.value!
        }
        
        if let state = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "state" }).first {
            loginData.state = state.value!
        }
        
        if let refresh_token = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "refresh_token" }).first {
            loginData.refreshToken = refresh_token.value!
        }
        
        if let error_description = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "error_description" }).first {
            loginData.errorDescription = error_description.value!
        }
        
        if let error = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "error" }).first {
            loginData.error = error.value!
        }
    }
    
    public func getRefreshToken(data:Data?){
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                
                if let accessToken = json["access_token"] as? String {
                    loginData.accessToken=accessToken
                }
                
                if let expiresIn = json["expires_in"] as? Int {
                    loginData.expiresIn=expiresIn
                }
                
                if let scope = json["scope"] as? String {
                    loginData.scope=scope
                }
                
                if let tokenType = json["token_type"] as? String {
                    loginData.tokenType=tokenType
                }
                
                if let id_token = json["id_token"] as? String {
                    loginData.idToken=id_token
                }
                
                if let refresh_token = json["refresh_token"] as? String {
                    loginData.refreshToken=refresh_token
                }
                
                if let error_description = json["error_description"] as? String {
                    loginData.errorDescription=error_description
                }
                
                if let error = json["error"] as? String {
                    loginData.error=error
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    public func getTokenIntrospection(data:Data?){
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let active = json["active"] as? Bool {
                    introspection.active=active
                }
                
                if let client_id = json["client_id"] as? String {
                    introspection.clientId=client_id
                }
                
                if let exp = json["exp"] as? Int {
                    introspection.exp=exp
                }
                
                if let iat = json["iat"] as? Int {
                    introspection.iat=iat
                }
                
                if let iss = json["iss"] as? String {
                    introspection.iss=iss
                }
                
                if let scope = json["scope"] as? String {
                    introspection.scope=scope
                }
                
                if let token_type = json["token_type"] as? String {
                    introspection.tokenType=token_type
                }
                
                if let sub = json["sub"] as? String {
                    let subData = Data(sub.utf8)
                    if let jsonSub =  try JSONSerialization.jsonObject(with: subData, options: []) as? [String: Any]{
                    
                        if let accountId = jsonSub["accountId"] as? String {
                            introspection.sub.customerId=accountId
                        }
                        
                        if let user = jsonSub["user"] as? String {
                            introspection.sub.user=user
                        }
                    }
                }
                
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
    }
    
    public func getUserInfo(data:Data?){
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let sub = json["sub"] as? String {
                    userInfo.customerId=sub
                }
                if let email = json["email"] as? String {
                    userInfo.email=email
                }
                if let first = json["first"] as? String {
                    userInfo.first=first
                }
                if let last = json["last"] as? String {
                    userInfo.last=last
                }
                if let title = json["title"] as? String {
                    userInfo.title=title
                }
                if let error_description = json["error_description"] as? String {
                    userInfo.errorDescription=error_description
                }
                
                if let error = json["error"] as? String {
                    userInfo.error=error
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    public func getResultCode(data: String) {
        if(URLComponents(string: (data))!.queryItems?.isEmpty ?? true ){
            return
        }
        
        if let resultCode = URLComponents(string: (data))!.queryItems!.filter({ $0.name == "resultCode" }).first {
            resultCodeData.resultCode = resultCode.value!
        }
    }
    
}
