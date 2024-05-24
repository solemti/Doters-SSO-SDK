//
//  SignInError.swift
//  SSODoters
//
//  Created by GrupoSti on 23/05/24.
//

import Foundation

enum SignInError: Int, Error {
    case processCanceled = 1
    case unknownError = 99

    var localizedDescription: String {
        switch self {
        case .processCanceled:
            return "PROCESS_CANCELED"
        case .unknownError:
            return "UNKNOWN_ERROR"
        }
    }
}
