//
//  ViewController.swift
//  SSODoters
//
//  Created by 82123683 on 11/03/2022.
//  Copyright (c) 2022 82123683. All rights reserved.
//

import UIKit
import SSODoters

class ViewController: UIViewController {
    
    @IBOutlet weak var lblData: UILabel!
    var loginDataGlobal = LoginData()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblData.font = UIFont.systemFont(ofSize: 12)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        let auth = AuthSSODoters()
        auth.setUrl(url: "https://auth-test.doters.io/")
        auth.setClientId(clientId: "viva-web")
        auth.setClientSecret(clientSecret: "GlMTbnwjRA")
        auth.setLanguage(language: "es-MX")
        auth.setScheme(sheme: "dosso")
        
        auth.signIn { data, error in
            self.loginDataGlobal = data
            self.lblData.numberOfLines = 0
            self.lblData.textAlignment = .left
            self.lblData.text = "Login.-\n Acces Token: \(data.getAccessToken())\n Refresh: \(data.getRefreshToken())\n Id Token: \(data.getIdToken())\n Expires In: \(data.getExpiresIn())\n Scope In: \(data.getScope())\n token type: \(data.getTokenType())\n State: \(data.getState())"

        }
    }
    @IBAction func logOut(_ sender: Any) {
            let auth = AuthSSODoters()
            auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
            auth.setClientId(clientId: "viva-web")
            auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            auth.setScheme(sheme: "dosso")
                
            auth.logOut { dato, error in
                
                self.lblData.numberOfLines = 0
                self.lblData.textAlignment = .left
                self.lblData.text = dato
            }
    }
    @IBAction func refresh(_ sender: Any) {
        
            let auth = AuthSSODoters()
            auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
            auth.setClientId(clientId: "viva-web")
            auth.setClientSecret(clientSecret: "GlMTbnwjRA")
                
            auth.refreshToken(token: loginDataGlobal.getRefreshToken(), completion: { data, error in
                if(data.getError().isEmpty){
                    self.lblData.text = "Refresh.-\n Acces Token: \(data.getAccessToken())\n Id Token: \(data.getIdToken())\n Refresh: \(data.getRefreshToken())\n Expires In: \(data.getExpiresIn())\n Scope: \(data.getExpiresIn())\n tokenType: \(data.getTokenType())"
                }else{
                    self.lblData.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
                }
            
            })
        
    }
    @IBAction func introspection(_ sender: Any) {
        let auth = AuthSSODoters()
        auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
        auth.setClientId(clientId: "viva-web")
        auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            
        auth.tokenIntrospection(accessToken: loginDataGlobal.getAccessToken(), completion: { data, error in
            self.lblData.numberOfLines = 0
            self.lblData.textAlignment = .left
            if(data.getError().isEmpty){
                self.lblData.text = "Introspection.-\n Active: \(data.getActive())\n Client ID: \(data.getClientId())\n Iat: \(data.getIat())\n exp: \(data.getExp())\n Iss: \(data.getIss())\n scope: \(data.getScope())\n User: \(data.getSub().getUser())\n CustomerId: \(data.getSub().getCustomerId())\n tokenType: \(data.getTokenType())"
            }else{
                self.lblData.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
            }
            
        })
    }
    @IBAction func userInfo(_ sender: Any) {
        let auth = AuthSSODoters()
        auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
        auth.setClientId(clientId: "viva-web")
        auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            
        auth.userInfo(accessToken: loginDataGlobal.getAccessToken(), completion: { data, error in
            if(data.getError().isEmpty){
                self.lblData.text = "User info.-\n First: \(data.getFirst())\n last: \(data.getLast())\n CustomerId: \(data.getCustomerId())\n Email: \(data.getEmail())\n Title: \(data.getTitle())"
            }else{
                self.lblData.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
            }
            
        })
    }
}

