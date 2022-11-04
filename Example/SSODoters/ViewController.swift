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
    
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var lblIntrospection: UILabel!
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblLogOut: UILabel!
    var loginDataGlobal = LoginData()
    @IBOutlet weak var lblRefresh: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            self.labelLogin.numberOfLines = 0
            self.labelLogin.textAlignment = .left
            self.labelLogin.text = "Acces Token: \(data.getAccessToken())\n Refresh: \(data.getRefreshToken())"
        }
    }
    @IBAction func logOut(_ sender: Any) {
            let auth = AuthSSODoters()
            auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
            auth.setClientId(clientId: "viva-web")
            auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            auth.setScheme(sheme: "dosso")
                
            auth.logOut { dato, error in
                
                self.lblLogOut.numberOfLines = 0
                self.lblLogOut.textAlignment = .left
                self.lblLogOut.text = dato
            }
    }
    @IBAction func refresh(_ sender: Any) {
        
            let auth = AuthSSODoters()
            auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
            auth.setClientId(clientId: "viva-web")
            auth.setClientSecret(clientSecret: "GlMTbnwjRA")
                
            auth.RefreshToken(token: loginDataGlobal.getRefreshToken(), completion: { data, error in
                if(data.getError().isEmpty){
                    self.lblRefresh.numberOfLines = 0
                    self.lblRefresh.textAlignment = .left
                    self.lblRefresh.text = "Acces Token: \(data.getAccessToken())\n Refresh: \(data.getRefreshToken())"
                }else{
                    self.lblRefresh.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
                }
            
            })
        
    }
    @IBAction func introspection(_ sender: Any) {
        let auth = AuthSSODoters()
        auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
        auth.setClientId(clientId: "viva-web")
        auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            
        auth.TokenIntrospection(access_token: loginDataGlobal.getAccessToken(), completion: { data, error in
            self.lblIntrospection.numberOfLines = 0
            self.lblIntrospection.textAlignment = .left
            if(data.getError().isEmpty){
                self.lblIntrospection.text = "Active: \(data.getActive())\n Client ID: \(data.getClient_id())\n User: \(data.getSub().getUser())"
            }else{
                self.lblIntrospection.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
            }
            
        })
    }
    @IBAction func userInfo(_ sender: Any) {
        let auth = AuthSSODoters()
        auth.setAPIUrl(APIurl: "https://auth-api-gw-test.doters.io/v1")
        auth.setClientId(clientId: "viva-web")
        auth.setClientSecret(clientSecret: "GlMTbnwjRA")
            
        auth.UserInfo(access_token: loginDataGlobal.getAccessToken(), completion: { data, error in
            if(data.getError().isEmpty){
                self.lblUserInfo.text = "Email: \(data.getEmail())\n First: \(data.getFirst())\n Last: \(data.getLast())"
            }else{
                self.lblUserInfo.text = "Error: \(data.getError())\n Error Description: \(data.getErrorDescription())"
            }
            
        })
    }
}

