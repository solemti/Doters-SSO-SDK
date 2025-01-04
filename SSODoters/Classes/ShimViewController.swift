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
        if let anchor = globalPresentationAnchor {
            return anchor
        }

        if Thread.isMainThread {
            return ASPresentationAnchor()
        } else {
            var createdAnchor: ASPresentationAnchor?
            let semaphore = DispatchSemaphore(value: 0)
            
            DispatchQueue.main.async {
                createdAnchor = ASPresentationAnchor()
                semaphore.signal()
            }
            
            semaphore.wait()
            return createdAnchor!
        }
    }
}
