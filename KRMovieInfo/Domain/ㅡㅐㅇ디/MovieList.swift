//
//  MovieList.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation

// MARK: - MovieList
struct MovieListItemDomain: Decodable {
    let title, titleEn, prductionYear: String
    let openDate: String
    let movieType: String
    let productionState: String
    let nationAll, genreAll, representingNation, representingGenre: String
    let directors: [String]
    let companys: [String]

    enum CodingKeys: String, CodingKey {
        case title = "movieNm"
        case titleEn = "movieNmEn"
        case prductionYear = "prdtYear"
        case openDate = "openDt"
        case movieType = "typeNm"
        case productionState = "prdtStatNm"
        case nationAll = "nationAlt"
        case genreAll = "genreAlt"
        case representingNation = "repNationNm"
        case representingGenre = "repGenreNm"
        case directors = "directors"
        case companys = "companys"
    }
}
