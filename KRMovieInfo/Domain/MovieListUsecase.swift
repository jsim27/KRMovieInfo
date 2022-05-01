//
//  MovieListUsecase.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation
import RxSwift

class MovieListUsecase {
    let repository: MovieListRepository

    init(movieListRepository: MovieListRepository) {
        self.repository = movieListRepository
    }

    func fetchMovieList(title: String) -> Observable<MovieListDomain> {
        return repository.fetchMovieList(director: title)
    }
    
    func fetchMovieList(director: String) -> Observable<MovieListDomain> {
        return repository.fetchMovieList(director: director)
    }

}
