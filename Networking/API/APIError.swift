//
//  APIError.swift
//  Networking
//
//  Created by Omran on 2020-02-20.
//  Copyright © 2020 Omran. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
    
    case unKnown
    case encodingFailed
    case encodingUrlFailed
    case encodingJsonFailed
    case errorCreatingUrl
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .unKnown: return "unknown"
        case .custom(let errString): return errString
        case .encodingFailed: return "encodingFailed"
        case .encodingUrlFailed: return "encodingUrlFailed"
        case .encodingJsonFailed: return "encodingJsonFailed"
        case .errorCreatingUrl: return "errorCreatingUrl"
        }
    }
}
