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

    init(coordinator: DetailViewCoordinator, useCase: MovieDetailUseCase) {
        self.coordinator = coordinator
        self.movieDetailUseCase = useCase
    }

    struct Input {

    }
    struct Output {

    }

    func transform(input: Input) -> Output {



        return Output()
    }
}
