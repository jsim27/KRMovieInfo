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

    private let coordinator: SceneCoordinator
    private let movieSearchUseCase: MovieListUsecase

    init(coordinator: SceneCoordinator, useCase: MovieListUsecase) {
        self.coordinator = coordinator
        self.movieSearchUseCase = useCase
    }

    struct Input {
        let viewWillAppear: Observable<Void>
        let searchBarDidChange: Observable<String>
        let searchBarScopeIndex: Observable<Int>
    }
    struct Output {
        let itemFetched: Driver<[MovieListItemWithAsyncImage]>
    }

    func transform(input: Input) -> Output {
        let queryEvent = Observable.merge(
            input.viewWillAppear.map { _ in "" },
            input.searchBarDidChange
        )
        let itemFetched = Observable.combineLatest(
            queryEvent,
            input.searchBarScopeIndex
        )
            .flatMapLatest { queryEvent, queryType -> Observable<[MovieListItemWithAsyncImage]> in
                if queryType == 0 {
                    return self.movieSearchUseCase.fetchMovieList(title: queryEvent, page: 1, itemsPerPage: 100)
                }
                return self.movieSearchUseCase.fetchMovieList(director: queryEvent, page: 1, itemsPerPage: 100)
            }
            .asDriver(onErrorJustReturn: [])

        return Output(itemFetched: itemFetched)
    }
}
