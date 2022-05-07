//
//  NaverSearchRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/07.
//

import Foundation

struct NaverSearchRequest: APIRequest, NaverSearchInfoOwner {

    typealias Response = NaverSearchResponse

    var method: HTTPMethod = .GET
    let query: [String: Any]
    var header: [String: String]? {
        [
            "X-Naver-Client-Id": self.apiKey,
            "X-Naver-Client-Secret": self.apiSecret
        ]
    }
    var urlComponents: URLComponents? {
        var urlComponents = URLComponents(string: self.base)
        urlComponents?.percentEncodedQueryItems = self.query.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            )
        }
        return urlComponents
    }

    init(query: String, procudtionYearFrom: Int, productionYearTo: Int, page: Int = 1, itemsPerPage: Int = 10) {
        self.query =  [
            "query": query,
            "start": page,
            "display": itemsPerPage,
            "yearfrom": procudtionYearFrom,
            "yearto": productionYearTo
        ]
    }
}

protocol NaverSearchInfoOwner: APIRequest {

    var base: String { get }
    var apiKey: String { get }
    var apiSecret: String { get }
}

extension NaverSearchInfoOwner {

    var base: String {
        return "https://openapi.naver.com/v1/search/movie.json"
    }
    var apiKey: String { Bundle.main.naverSearchAPIKey }
    var apiSecret: String { Bundle.main.naverSearchAPISecret }
}
