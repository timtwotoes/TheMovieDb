//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Tim Wolff on 06/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import XCTest
@testable import TheMovieDb

class TheMovieDbTests: XCTestCase {
    private let apiKey = "8848b19c00e4112b4d7449c34fa2c741"
    private let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ODQ4YjE5YzAwZTQxMTJiNGQ3NDQ5YzM0ZmEyYzc0MSIsInN1YiI6IjRlMTViNGE1NWU3M2Q2N2M2MjAwMDA1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.K2OWmrva_3ttlP1yhwqnuKmms9qSWxQnK5S4wswfXzs"
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetConfigurationAPI() {
        let xpcExpectation = expectation(description: "Fetches configuration object from The Movie Db API")
        
        let client = TheMovieDbClient(apiKeyV3: apiKey, apiKeyV4: bearerToken)
        client.getConfiguration { (result) in
            switch result {
            case .localError(let error): XCTFail(error.localizedDescription)
            case .serverError(let statusCode, let message): XCTFail("Status code \(statusCode)\n\(String(data: message, encoding: .utf8)!)")
            case .success(object: _): break
            }
            xpcExpectation.fulfill()
        }
        
        wait(for: [xpcExpectation], timeout: 6.0)
    }

}
