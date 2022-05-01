//
//  URLSessionService.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

final class URLSessionService {
    let session = URLSession.shared
}

struct MovieListRequest {
    let base = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
}
