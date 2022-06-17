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

    private let coordinator: MovieSearchCoordinator
    private let movieSearchUseCase: MovieListUseCase

    init(coordinator: MovieSearchCoordinator, useCase: MovieListUseCase) {
        self.coordinator = coordinator
        self.movieSearchUseCase = useCase
    }

    struct Input {
        let viewWillAppear: Observable<Void>
        let searchBarDidChange: Observable<String>
        let searchBarScopeIndex: Observable<Int>
        let collectionViewDidSelectItem: Observable<MovieListItemWithAsyncImage>
    }
    struct Output {
        let itemFetched: Driver<[MovieListItemWithAsyncImage]>
        let itemSelected: Driver<Void>
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
            .debug()
            .asDriver(onErrorJustReturn: [])

        let itemSelected = input.collectionViewDidSelectItem
            .map { $0.movieInfo.code }
            .flatMap(self.coordinator.coordinateToMovieDetail(movieCode:))
            .asDriver(onErrorJustReturn: ())

        return Output(
            itemFetched: itemFetched,
            itemSelected: itemSelected
        )
    }
}
