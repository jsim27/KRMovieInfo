//
//  MovieDetailRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation

struct MovieDetailRequest: APIRequest, MovieDetailAPIInfoOwner {

    typealias Response = MovieDetailResponse

    var method: HTTPMethod = .GET
    var query: [String: String]
    var header: [String: String]?
    var urlComponents: URLComponents? {
        var urlComponents = URLComponents(string: self.base + self.path)
        urlComponents?.percentEncodedQueryItems = self.query.map {
            URLQueryItem(
                name: $0.key,
                value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            )
        }
        urlComponents?.queryItems?.append(URLQueryItem(name: "key", value: self.apiKey))
        return urlComponents
    }

    init(code: String) {
        self.query = [:]
        self.query.updateValue(code, forKey: "movieCd")
    }
}
