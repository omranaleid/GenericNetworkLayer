//
//  RequestBuilder.swift
//  Networking
//
//  Created by Omran on 2020-02-20.
//  Copyright © 2020 Omran. All rights reserved.
//

import Foundation

class URLRequestBuilder {
    
    private let endPoint: APIEndpoint
    private let baseURL: String
    private let timeoutInterval: TimeInterval
    private let cashPolicy: URLRequest.CachePolicy
    private let encoder: ParametersEncoder
    
    init(endPoint: APIEndpoint,
         baseURL: String,
         timeoutInterval: TimeInterval = 60,
         cashPolicy: URLRequest.CachePolicy = .reloadIgnoringCacheData) {
        self.endPoint = endPoint
        self.baseURL = baseURL
        self.cashPolicy = cashPolicy
        self.timeoutInterval = timeoutInterval
        encoder = ParametersEncoder()
    }
    
    func getRequest() throws -> URLRequest {
        
        guard let url = getFullUrl() else {
            throw APIError.errorCreatingUrl
        }

        var request = URLRequest(url: url, cachePolicy: cashPolicy, timeoutInterval: timeoutInterval)
        
        do {
            try encoder.decode(request: &request, params: endPoint.bodyParams)
        } catch {
            throw error
        }
        
        return request
    }
}

private extension URLRequestBuilder {
    
    private func getFullUrl() -> URL? {
        
        var urlString = "\(baseURL)\(endPoint.path)"
        
        if let query = endPoint.queryParams, !query.isEmpty {
            var queryString = "?"
            query.forEach { (arg) in
                let (key, value) = arg
                queryString.append("\(key)=\(value)")
            }
            urlString.append(queryString)
        }
        
        guard let url = URL(string: urlString) else {
            print("error creating url for the enpoint \(endPoint)")
            return nil
        }
        
        return url
    }
}
