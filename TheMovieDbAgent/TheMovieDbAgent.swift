//
//  TheMovieDbAgent.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 06/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

@objc class TheMovieDbAgent: NSObject, TheMovieDbAPI {
    public func request(_ request: URLRequest, withReply reply: @escaping ReplyHandler) {
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                reply(error, Int.max, nil)
            } else {
                // We know the HTTP protocol is used - it's okay to assume the response is an HTTP response.
                let statusCode = (response as! HTTPURLResponse).statusCode
                reply(nil, statusCode, data)
            }
            }.resume()
    }
}
