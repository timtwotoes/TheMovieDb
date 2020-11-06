//
//  Configuration.swift
//  TheMovieDb
//
//  Created by Tim Wolff on 03/11/2020.
//  Copyright © 2020 Tim Wolff. All rights reserved.
//

import Foundation

public struct Configuration: Codable {
    public struct Images: Codable {
        public let baseURL: String
        public let secureBaseURL: String
        public let backdropSizes: [String]
        public let logoSizes: [String]
        public let posterSizes: [String]
        public let profileSizes: [String]
        public let stillSizes: [String]
    }

    public let images: Images
    public let changeKeys: [String]
}

extension Configuration {
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

extension Configuration.Images {
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
