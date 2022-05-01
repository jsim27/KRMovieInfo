//
//  MovielistRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

struct MovieListRequest: APIRequest {

    typealias APIResponse = MovieListResponse

    let base = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
    var method: HTTPMethod = .GET
    let query: [String: Any]
}
