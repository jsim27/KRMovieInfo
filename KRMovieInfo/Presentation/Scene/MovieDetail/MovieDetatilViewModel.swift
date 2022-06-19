//
//  MovieDetatilViewModel.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: ViewModelProtocol {

    private let coordinator: DetailViewCoordinator
    private let movieDetailUseCase: MovieDetailUseCase
    private let movieCode: String

    init(coordinator: DetailViewCoordinator, useCase: MovieDetailUseCase, movieCode: String) {
        self.coordinator = coordinator
        self.movieDetailUseCase = useCase
        self.movieCode = movieCode
    }

    struct Input {
        let viewWillAppear: Observable<Void>
    }
    struct Output {
        let navigationTitle: Observable<String>
    }

    func transform(input: Input) -> Output {
        let navigationTitle = input.viewWillAppear
            .flatMap { _ in
                self.movieDetailUseCase.fetchMovieDetail(code: self.movieCode)
            }
            .map { $0.title }

        return Output(navigationTitle: navigationTitle)
    }
}
