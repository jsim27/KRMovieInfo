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

    init(movieDetailRepository: MovieDetailRepository) {
        self.movieDetailRepository = movieDetailRepository
    }

    func fetchMovieDetail(code: String) -> Observable<MovieDetailEntity> {
        return self.movieDetailRepository.fetchMovieDetail(code: code)
    }
}
