//
//  TheMovieDbClientResult.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 03/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public enum TheMovieDbClientResult<T>: Error {
    case localError(Error)
    case serverError(statusCode: Int, message: Data)
    case success(object: T)
}
