//
//  MovieDetailResponse.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation

struct MovieDetailResponse: APIResponse, Decodable {

    let movieInfoResult: MovieDetailResult
}

// MARK: - MovieInfoResult
struct MovieDetailResult: Decodable {
    
    let movieInfo: MovieDetail
}

// MARK: - MovieInfo
struct MovieDetail: Decodable {
    let movieCode, title, titleEn, titleOriginal: String
    let showTime, prductionYear, openDate, productionState: String
    let movieType: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [String]
    let companys: [Company]
    let audits, staffs: [String]

    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case title = "movieNm"
        case titleEn = "movieNmEn"
        case titleOriginal = "movieNmOg"
        case showTime = "showTm"
        case prductionYear = "prdtYear"
        case openDate = "openDt"
        case productionState = "prdtStatNm"
        case movieType = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case companys
        case audits
        case staffs
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let genre: String

    private enum CodingKeys: String, CodingKey {
        case genre = "genreNm"
    }
}

// MARK: - Nation
struct Nation: Decodable {
    let nation: String

    private enum CodingKeys: String, CodingKey {
        case nation = "nationNm"
    }
}
