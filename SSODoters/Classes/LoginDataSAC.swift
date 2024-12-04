//
//  LoginDataSAC.swift
//  SSODoters
//
//  Created by GrupoSti on 30/11/24.
//

import Foundation

public class LoginDataSAC: NSObject{
    
    var activationCode:String
    var expiresIn:Int
    var flow:String
    var sub:String
    var tokenType:String
    var state:String
    var error:String
    var errorDescription:String
    
    public override init(){
        activationCode = ""
        expiresIn = 0
        flow = ""
        sub = ""
        tokenType = ""
        state = ""
        error = ""
        errorDescription = ""
    }
    
    public func getActivationCode() -> String{
        return activationCode
    }
    
    public func getExpiresIn() -> Int{
        return expiresIn
    }
    
    public func getFlow() -> String{
        return flow
    }

    public func getSub() -> String{
        return sub
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

