//
//  MovieAPIInfoOwner.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation

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
