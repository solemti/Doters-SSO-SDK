//
//  Introspection.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class IntrospectionData: NSObject{
    
    var active:Bool
    var sub:SubData
    var clientId:String
    var exp:Int
    var iat:Int
    var iss:String
    var scope:String
    var tokenType:String
    var error:String
    var errorDescription:String
    
    public override init(){
        active = false
        sub = SubData()
        clientId = ""
        exp = 0
        iat = 0
        iss = ""
        scope = ""
        tokenType = ""
        error = ""
        errorDescription = ""
    }
    
    public func getActive() -> Bool{
        return active
    }
    
    public func getClientId() -> String{
        return clientId
    }
    
    public func getExp() -> Int{
        return exp
    }
    
    public func getSub() -> SubData{
        return sub
    }
    
    public func getIat() -> Int{
        return iat
    }
    
    public func getIss() -> String{
        return iss
    }
    
    public func getScope() -> String{
        return scope
    }
    
    public func getTokenType() -> String{
        return tokenType
    }
    
    public func getError() -> String{
        return error
    }
    
    public func getErrorDescription() -> String{
        return errorDescription
    }
    
}
