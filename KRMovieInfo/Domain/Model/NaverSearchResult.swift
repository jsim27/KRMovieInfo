//
//  NaverSearchResult.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/08.
//

import Foundation

struct NaverSearchResult: Decodable {

    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
}
