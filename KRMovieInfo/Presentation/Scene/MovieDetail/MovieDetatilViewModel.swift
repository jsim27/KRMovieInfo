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
        let moviePoster: Observable<Data>
        let movieTitle: Observable<String>
        let movieInfo: Observable<String>
        let userRating: Observable<String>
    }

    func transform(input: Input) -> Output {
        let fetchMovieInfo = input.viewWillAppear
            .flatMap { _ in
                self.movieDetailUseCase.fetchMovieDetail(code: self.movieCode)
            }
            .share()

        let naverMovieInfo = fetchMovieInfo
            .flatMap(self.movieDetailUseCase.fetchNaverMovieInfo)
            .share()

        let movieTitle = fetchMovieInfo
            .map { $0.title }

        let movieInfo = fetchMovieInfo
            .map { [$0.prductionYear, $0.productionState, $0.genres].joined(separator: " • ")}

        let userRating = naverMovieInfo
            .map { $0.userRating }

        let posterData = naverMovieInfo
            .flatMap(self.movieDetailUseCase.fetchImage(from:))

        return Output(
            moviePoster: posterData,
            movieTitle: movieTitle,
            movieInfo: movieInfo,
            userRating: userRating
        )
    }
}
