//
//  Recource.swift
//  Networking
//
//  Created by Omran on 2020-02-13.
//  Copyright © 2020 Omran. All rights reserved.
//

import Foundation

protocol APIEndpoint {
    
    var path: String { get }
    var method: String { get }
    var queryParams: [String: String]? { get }
    var bodyParams: BodyParameterEncodingType { get }
    var headers: [String: String] { get }
}

enum TestEnpoint: APIEndpoint {
    
    case weather(queryParams: [String : String]), endpoint2
    
    var path: String {
        
        switch self {
        case .weather(queryParams: _): return "/weather"
        default: return ""
        }
    }
    
    var method: String {
        
        switch self {
        case .weather(queryParams: _): return "GET"
        default: return ""
        }
    }
    
    var queryParams: [String : String]? {
        
        switch self {
        case .weather(queryParams: let queryParams): return queryParams
        default: return nil
        }
    }
    
    var bodyParams: BodyParameterEncodingType {
        
        switch self {
        case .weather(queryParams: _): return .none
        default: return .none
        }
    }
    
    var headers: [String: String] {
        
        switch self {
        case .weather(queryParams: _): return [:]
        default: return [:]
        }
    }
}

struct WeatherResponse: Codable {
    
    var weather: WeatherObject
}

struct WeatherObject: Codable {
    
    var id: Int
    var main: String
    var icon: String
}
