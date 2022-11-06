//
//  Introspection.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class Introspection: NSObject{
    
    var active:Bool
    var sub:SubIntrospection
    var client_id:String
    var exp:Int
    var iat:Int
    var iss:String
    var scope:String
    var token_type:String
    var error:String
    var errorDescription:String
    
    public override init(){
        active = false
        sub = SubIntrospection()
        client_id = ""
        exp = 0
        iat = 0
        iss = ""
        scope = ""
        token_type = ""
        error = ""
        errorDescription = ""
    }
    
    public func getActive() -> Bool{
        return active
    }
    
    public func getClient_id() -> String{
        return client_id
    }
    
    public func getExp() -> Int{
        return exp
    }
    
    public func getSub() -> SubIntrospection{
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
    
    public func getToken_type() -> String{
        return token_type
    }
    
    public func getError() -> String{
        return error
    }
    
    public func getErrorDescription() -> String{
        return errorDescription
    }
    
}
