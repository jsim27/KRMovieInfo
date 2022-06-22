//
//  NaverSearchResponse.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/07.
//

import Foundation

struct NaverSearchResponse: Codable, APIResponse {

    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

struct Item: Codable {

    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
}
