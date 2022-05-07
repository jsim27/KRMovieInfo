//
//  MovieSearchViewModel.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/03.
//

import Foundation
import RxSwift
import RxCocoa

class MovieSearchViewModel: ViewModelProtocol {

    private let useCase = MovieListUsecase(movieListRepository: DefaultMovieListRepository())

    struct Input {
        let viewWillAppear: Observable<Void>
    }
    struct Output {
        let itemFetched: Driver<[MovieListItem]>
    }

    func transform(input: Input) -> Output {

        let itemFetched = input.viewWillAppear
            .flatMap {
                self.useCase.fetchMovieList(title: "", page: 1, itemsPerPage: 100)
            }
            .asDriver(onErrorJustReturn: [])

        return Output(itemFetched: itemFetched)
    }
}
