//
//  LoginData.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class LoginData: NSObject{
    
    var access_token:String
    var expires_in:Int
    var id_token:String
    var refresh_token:String
    var scope:String
    var token_type:String
    var state:String
    var error:String
    var errorDescription:String
    
    public override init(){
        access_token = ""
        expires_in = 0
        id_token = ""
        scope = ""
        token_type = ""
        refresh_token = ""
        state = ""
        error = ""
        errorDescription = ""
    }
    
    public func getAccessToken() -> String{
        return access_token
    }
    
    public func getExpiresIn() -> Int{
        return expires_in
    }
    
    public func getIdToken() -> String{
        return id_token
    }
    
    public func getRefreshToken() -> String{
        return refresh_token
    }
    
    public func getError() -> String{
        return error
    }
    
    public func getErrorDescription() -> String{
        return errorDescription
    }
    
}
