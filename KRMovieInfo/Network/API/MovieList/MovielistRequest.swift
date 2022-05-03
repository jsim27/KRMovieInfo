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
    let query: [String: String]
}

protocol MovieAPIInfoOwner: APIRequest {

    var base: String { get }
    var apiKey: String { get }
}

extension MovieAPIInfoOwner {

    var base: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
    }
    var apiKey: String { Bundle.main.koficMainAPIKey }
}
