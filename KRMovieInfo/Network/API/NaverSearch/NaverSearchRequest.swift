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
        var urlComponents = URLComponents(string: self.base + self.path)
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
