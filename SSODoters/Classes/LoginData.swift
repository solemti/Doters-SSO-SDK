//
//  LoginData.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class LoginData: NSObject{
    
    var accessToken:String
    var expiresIn:Int
    var idToken:String
    var refreshToken:String
    var scope:String
    var tokenType:String
    var state:String
    var error:String
    var errorDescription:String
    
    public override init(){
        accessToken = ""
        expiresIn = 0
        idToken = ""
        scope = ""
        tokenType = ""
        refreshToken = ""
        state = ""
        error = ""
        errorDescription = ""
    }
    
    public func getAccessToken() -> String{
        return accessToken
    }
    
    public func getExpiresIn() -> Int{
        return expiresIn
    }
    
    public func getIdToken() -> String{
        return idToken
    }
    
    public func getRefreshToken() -> String{
        return refreshToken
    }
    
    public func getScope() -> String{
        return scope
    }
    
    public func getTokenType() -> String{
        return tokenType
    }
    
    public func getState() -> String{
        return state
    }
    
    public func getError() -> String{
        return error
    }
    
    public func getErrorDescription() -> String{
        return errorDescription
    }
    
}
