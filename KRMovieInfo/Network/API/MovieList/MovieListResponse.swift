//
//  MovieListResponse.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

struct MovieListResponse: APIResponse, Decodable {

    let totalCount: Int
    let movieList: [MovieList]
}

// MARK: - MovieList
struct MovieList: Decodable {

    let title, titleEn, prductionYear: String
    let openDate: String
    let movieType: MovieType
    let productionState: ProductionState
    let nationAll, genreAll, representingNation, representingGenre: String
    let directors: [Director]
    let companys: [Company]

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

// MARK: - Company
struct Company: Decodable {

    let companyName: String

    enum CodingKeys: String, CodingKey {
        case companyName = "companyNm"
    }
}

// MARK: - Director
struct Director: Decodable {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

enum ProductionState: String, Decodable {
    case release = "개봉"
    case preRelease = "개봉예정"
    case other = "기타"
}

enum MovieType: String, Decodable {
    case omnibus = "옴니버스"
    case fullLength = "장편"
}
