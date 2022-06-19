//
//  MovieDetailResponse.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation

struct MovieDetailResponse: APIResponse, Decodable {

    let movieDetailResult: MovieDetailResult

    private enum CodingKeys: String, CodingKey {
        case movieDetailResult = "movieInfoResult"
    }
}

// MARK: - MovieDetailResult
struct MovieDetailResult: Decodable {

    let movieInfo: MovieDetailInfo
}

// MARK: - MovieDetail
struct MovieDetailInfo: Decodable {
    let movieCode, title, titleEn, titleOriginal: String
    let showTime, prductionYear, openDate, productionState: String
    let movieType: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Directors]
    let actors: [Actor]
    let audits: [Audit]
    let staffs: [Staff]

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
        case nations = "nations"
        case genres = "genres"
        case directors
        case actors
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

// MARK: - Actor
struct Actor: Codable {
    let peopleNm, peopleNmEn: String
}

// MARK: - Audit
struct Audit: Decodable {
    let auditNumber, watchGrade: String

    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGrade = "watchGradeNm"
    }
}
// MARK: - Director
struct Directors: Decodable {

    let name: String

    private enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

// MARK: - Staff
struct Staff: Codable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}
