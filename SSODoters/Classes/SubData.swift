//
//  SubIntrospection.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class SubData: NSObject{
    
    var customerId:String
    var user:String
    
    public override init(){
        customerId = ""
        user = ""
    }
    
    public func getCustomerId() -> String{
        return customerId
    }
    
    public func getUser() -> String{
        return user
    }
}
