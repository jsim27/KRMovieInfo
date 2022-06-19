//
//  DefaultMovieDetailRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation
import RxSwift

class DefaultMovieDetailRepository: MovieDetailRepository {

    let service = URLSessionService()

    func fetchMovieDetail(code: String) -> Observable<MovieDetailEntity> {
        return self.service.rx.execute(
            request: MovieDetailRequest(code: code),
            isCacheNeeded: false
        )
        .map { $0.toDomain() }
    }
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
            nations: movieDetail.nations
                .map { $0.nation }
                .joined(separator: ", "),
            genres: movieDetail.genres
                .map { $0.genre }
                .joined(separator: ", "),
            directors: movieDetail.directors
                .map { $0.name }
                .joined(separator: ", "),
            actors: movieDetail.actors
                .map { $0.peopleNm }
                .joined(separator: ", "),
            audits: movieDetail.audits
                .map { $0.watchGrade }
                .joined(separator: ", "),
            staffs: movieDetail.staffs
                .map { $0.peopleNm }
                .joined(separator: ", ")
        )
    }
}
