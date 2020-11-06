//
//  TheMovieDbAPI.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 03/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public typealias ReplyHandler = (_ error: Error?, _ statusCode: Int, _ data: Data?) -> ()

@objc public protocol TheMovieDbAPI {
    func request(_ request: URLRequest, withReply reply: @escaping ReplyHandler)
}
