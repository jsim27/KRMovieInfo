//
//  MovieListResponse.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

struct MovieListResponse: APIResponse, Decodable {

    let movieListResult: MovieListResult
}

// MARK: - MovieListResult
struct MovieListResult: Decodable {

    let totalCount: Int
    let movieList: [MovieInfo]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "totCnt"
        case movieList
    }
}

// MARK: - MovieList
struct MovieInfo: Decodable {

    let title, titleEn, prductionYear: String
    let openDate: String
    let movieType: String
    let productionState: String
    let nationAll, genreAll, representingNation, representingGenre: String
    let directors: [Director]
    let companys: [Company]

    private enum CodingKeys: String, CodingKey {
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

    private enum CodingKeys: String, CodingKey {
        case companyName = "companyNm"
    }
}

// MARK: - Director
struct Director: Decodable {

    let name: String

    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}
