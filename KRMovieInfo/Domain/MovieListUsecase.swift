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

    func fetchMovieList(title: String, page: Int, itemsPerPage: Int) -> Observable<[MovieListItem]> {
        return self.repository.fetchMovieList(title: title, page: page, itemsPerPage: itemsPerPage)
    }

    func fetchMovieList(director: String, page: Int, itemsPerPage: Int) -> Observable<[MovieListItem]> {
        return self.repository.fetchMovieList(director: director, page: page, itemsPerPage: itemsPerPage)
    }

}
