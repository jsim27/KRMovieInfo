//
//  NaverSearchInfoOwner.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/19.
//

import Foundation

protocol NaverSearchInfoOwner: APIRequest {

    var base: String { get }
    var path: String { get }
    var apiKey: String { get }
    var apiSecret: String { get }
}

extension NaverSearchInfoOwner {

    var base: String {
        return "https://openapi.naver.com/v1/search/"
    }
    var path: String {
        return "movie.json"
    }
    var apiKey: String { Bundle.main.naverSearchAPIKey }
    var apiSecret: String { Bundle.main.naverSearchAPISecret }
}
