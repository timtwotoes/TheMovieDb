//
//  TheMovieDbClient.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 03/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public typealias ResultHandler<T: Codable> = (TheMovieDbClientResult<T>) -> ()

public class TheMovieDbClient {
    private let apiKeyV3: String
    private let apiKeyV4: String
    
    public init(apiKeyV3: String, apiKeyV4: String) {
        self.apiKeyV3 = apiKeyV3
        self.apiKeyV4 = apiKeyV4
    }
    
    private var apiV3: APIBuilder {
        return APIBuilder("https://api.themoviedb.org/3").add(query: "api_key", value: apiKeyV3)
    }
    
    private var apiV4: APIBuilder {
        return APIBuilder("https://api.themoviedb.org/4").set(header: "Authorization", value: "Bearer \(apiKeyV4)").set(header: "Content-Type", value: "application/json;charset=utf-8")
    }
    
    public func getConfiguration(result: @escaping ResultHandler<Configuration>) {
        send(apiV3.set(endpoint: "configuration").build(), handler: result)
    }
    
    private func send<T>(_ request: URLRequest, handler: @escaping ResultHandler<T>) {
        let connection = NSXPCConnection(serviceName: "dk.codepod.TheMovieDbAgent")
        connection.remoteObjectInterface = NSXPCInterface(with: TheMovieDbAPI.self)
        connection.resume()

        let api = connection.remoteObjectProxyWithErrorHandler { (error) in
            handler(.localError(error))
        } as! TheMovieDbAPI

        api.request(request) { (error, statusCode, data) in
            if let error = error {
                handler(TheMovieDbClientResult.localError(error))
            } else {
                switch statusCode {
                case 200...299:
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data!)
                        handler(.success(object: result))
                    } catch (let error) {
                        handler(.localError(error))
                    }
                default:
                    handler(.serverError(statusCode: statusCode, message: data!))
                }
            }
        }
    }
    
    
}
