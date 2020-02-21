//
//  APIManager.swift
//  Networking
//
//  Created by Omran on 2020-02-13.
//  Copyright © 2020 Omran. All rights reserved.
//

import Foundation

class APIManager {
    
    private let baseURL: String
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func makeApiCall<T: Codable>(at endpoint: APIEndpoint,
                                 for responseType: T.Type,
                     with handler: @escaping (Result<T,Error>) -> Void ) {
        
        let requestBuilder = URLRequestBuilder(endPoint: endpoint, baseURL: baseURL)
        let request: URLRequest
        
        do {
            request = try requestBuilder.getRequest()
        } catch {
            handler(.failure(error))
            return
        }
                
        defaultSession.dataTask(with: request) { (data, respose, error) in
            
            guard let response = respose as? HTTPURLResponse else {
                handler(.failure(APIError.unKnown))
                return
            }
            
            guard (200...300).contains(response.statusCode), let data = data else {
                handler(.failure(error ?? APIError.unKnown))
                return
            }
            
            do {
                let finalResponse = try JSONDecoder().decode(T.self, from: data)
                handler(.success(finalResponse))
            } catch {
                handler(.failure(error))
            }
        }.resume()
    }
}
