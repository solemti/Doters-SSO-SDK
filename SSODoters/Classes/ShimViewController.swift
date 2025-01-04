//
//  ShimViewController.swift
//  SSODoters
//
//  Created by GrupoSti on 03/11/22.
//

import Foundation
import AuthenticationServices

var globalPresentationAnchor: ASPresentationAnchor? = nil
class ShimViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return globalPresentationAnchor ?? {
            if Thread.isMainThread {
                return ASPresentationAnchor()
            } else {
                return DispatchQueue.main.sync {
                    ASPresentationAnchor()
                }
            }
        }()
    }
}
