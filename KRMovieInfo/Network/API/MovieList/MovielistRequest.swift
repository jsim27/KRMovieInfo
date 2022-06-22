//
//  MovielistRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

struct MovieListRequest: APIRequest, MovieAPIInfoOwner {

    typealias Response = MovieListResponse

    var method: HTTPMethod = .GET
    var query: [String: String]
    var header: [String: String]?
    var urlComponents: URLComponents? {
        var urlComponents = URLComponents(string: self.base)
        urlComponents?.percentEncodedQueryItems = self.query.map {
            URLQueryItem(
                name: $0.key,
                value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            )
        }
        urlComponents?.queryItems?.append(URLQueryItem(name: "key", value: self.apiKey))
        return urlComponents
    }

    init(title: String?, director: String?, page: Int = 1, itemsPerPage: Int = 10) {
        self.query =  [
            "curPage": "\(page)",
            "itemPerPage": "\(itemsPerPage)"
        ]
        if title != nil { self.query.updateValue(title ?? "", forKey: "movieNm") }
        if director != nil { self.query.updateValue(director ?? "", forKey: "directorNm") }
    }
}

protocol MovieAPIInfoOwner {

    var base: String { get }
    var apiKey: String { get }
}

extension MovieAPIInfoOwner {

    var base: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
    }
    var apiKey: String { Bundle.main.koficMainAPIKey }
}
