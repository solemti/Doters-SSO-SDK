//
//  ResultCodeData.swift
//  SSODoters
//
//  Created by GrupoSti on 02/02/24.
//

import Foundation

public class ResultCodeData: NSObject{
    var resultCode:String
    
    public override init(){
        resultCode = ""
    }
    
    public func getResultCode() -> String{
        return resultCode
    }
    
}
