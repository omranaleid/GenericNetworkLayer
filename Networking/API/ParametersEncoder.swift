//
//  ParametersEncoder.swift
//  Networking
//
//  Created by Omran on 2020-02-21.
//  Copyright © 2020 Omran. All rights reserved.
//

import Foundation

enum BodyParameterEncodingType {
    case none
    case json([String: Any])
    case urlencoded([String: Any])
}

class ParametersEncoder {
    
    func decode(request: inout URLRequest, params: BodyParameterEncodingType) throws {
        do {
            switch params {
            case .json(let jsonDic): try jsonDecoder(for: &request, jsonDic: jsonDic)
            case .urlencoded(let dictionary): try urlDecoder(for: &request, dictionary: dictionary)
            case .none: break
            }
        } catch {
            throw error
        }
    }
}

private extension ParametersEncoder {
    
    private func jsonDecoder(for request: inout URLRequest, jsonDic: [String: Any]) throws {
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            print("error adding http body parameters: \(jsonDic)")
            throw APIError.encodingJsonFailed
        }
    }
    
    private func urlDecoder(for request: inout URLRequest, dictionary: [String: Any]) throws {
        
        guard let url = request.url else {
            throw APIError.encodingUrlFailed
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !dictionary.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in dictionary {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
        
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
