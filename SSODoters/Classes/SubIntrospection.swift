//
//  SubIntrospection.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class SubIntrospection: NSObject{
    
    var accountId:String
    var user:String
    
    public override init(){
        accountId = ""
        user = ""
    }
    
    public func getAccountId() -> String{
        return accountId
    }
    
    public func getUser() -> String{
        return user
    }
}
