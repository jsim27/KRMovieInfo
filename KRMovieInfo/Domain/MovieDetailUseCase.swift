//
//  MovieDetailUseCase.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation
import RxSwift

class MovieDetailUseCase {

    let movieDetailRepository: MovieDetailRepository
    let naverSearchRepository: NaverSearchRepository

    init(movieDetailRepository: MovieDetailRepository, naverSearchRepository: NaverSearchRepository) {
        self.movieDetailRepository = movieDetailRepository
        self.naverSearchRepository = naverSearchRepository
    }

    func fetchMovieDetail(code: String) -> Observable<MovieDetailEntity> {
        return self.movieDetailRepository.fetchMovieDetail(code: code)
    }

    private func fetchNaverSearchResult(movieInfo: MovieListItem) -> Observable<[NaverSearchResult]> {
        return self.naverSearchRepository.fetchNaverSearchResult(
            query: movieInfo.title,
            procudtionYearFrom: Int(movieInfo.productionYear) ?? 0,
            productionYearTo: Int(movieInfo.openDate.prefix(4)) ?? 3000,
            page: 1,
            itemsPerPage: 5
        )
    }
}
