//
//  UserInfoData.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation

public class UserInfoData: NSObject{
    
    var customerId:String
    var email:String
    var first:String
    var last:String
    var title:String
    var error:String
    var errorDescription:String
    
    public override init(){
        customerId = ""
        first = ""
        last = ""
        title = ""
        email = ""
        error = ""
        errorDescription = ""
    }
    
    public func getFirst() -> String{
        return first
    }
    
    public func getLast() -> String{
        return last
    }
    
    public func getTitle() -> String{
        return title
    }
    
    public func getEmail() -> String{
        return email
    }
    
    public func getCustomerId() -> String{
        return customerId
    }
    
    public func getError() -> String{
        return error
    }
    
    public func getErrorDescription() -> String{
        return errorDescription
    }
    
}
