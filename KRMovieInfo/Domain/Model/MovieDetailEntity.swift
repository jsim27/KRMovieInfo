//
//  MovieDetailEntity.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/17.
//

import Foundation

struct MovieDetailEntity: Decodable {
    let movieCode, title, titleEn, titleOriginal: String
    let showTime, prductionYear, openDate, productionState: String
    let movieType: String
    let nations: String
    let genres: String
    let directors: String
    let actors: String
    let companys: String
    let audits, staffs: String
}

extension MovieDetailResponse {
    func toDomain() -> MovieDetailEntity {
        let movieDetail = self.movieDetailResult.movieInfo
        return MovieDetailEntity(
            movieCode: movieDetail.movieCode,
            title: movieDetail.title,
            titleEn: movieDetail.titleEn,
            titleOriginal: movieDetail.titleOriginal,
            showTime: movieDetail.showTime,
            prductionYear: movieDetail.prductionYear,
            openDate: movieDetail.openDate,
            productionState: movieDetail.productionState,
            movieType: movieDetail.movieType,
            nations: movieDetail.nations.map { $0.nation }.joined(separator: ", "),
            genres: movieDetail.genres.map { $0.genre }.joined(separator: ", "),
            directors: movieDetail.directors.map { $0.name }.joined(separator: ", "),
            actors: movieDetail.actors.joined(separator: ", "),
            companys: movieDetail.companys.map { $0.companyName }.joined(separator: ", "),
            audits: movieDetail.audits.joined(separator: ", "),
            staffs: movieDetail.staffs.joined(separator: ", ")
        )
    }
}
