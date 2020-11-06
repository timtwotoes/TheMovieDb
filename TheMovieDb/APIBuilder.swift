//
//  APIBuilder.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 04/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public class APIBuilder {
    private let host: String
    private var endpoint = ""
    private var queries = [URLQueryItem]()
    private var body: Data?
    private var headerFields = [String : String]()
    
    public init(_ host: String) {
        self.host = host
    }
    
    public func set(endpoint: String) -> APIBuilder {
        self.endpoint = endpoint
        return self
    }
    
    public func add(query name: String, value: String) -> APIBuilder {
        let query = URLQueryItem(name: name, value: value)
        queries.append(query)
        
        return self
    }
    
    public func set(body: Data?) -> APIBuilder {
        self.body = body
        return self
    }
    
    public func set(header field: String, value: String) -> APIBuilder {
        headerFields[field] = value
        return self
    }
    
    public func build() -> URLRequest {
        var components = URLComponents(string: host + "/" + endpoint)!
        components.queryItems = queries
        
        var request = URLRequest(url: components.url!)
        
        for (field, value) in headerFields {
            request.addValue(value, forHTTPHeaderField: field)
        }
        
        request.httpBody = body
        
        return request
    }
}
