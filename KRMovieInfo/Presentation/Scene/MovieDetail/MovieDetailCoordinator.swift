//
//  MovieDetailCoordinator.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/17.
//

import UIKit
import RxSwift

class DetailViewCoordinator: Coordinator<Void> {

    let identifier = UUID()
    let navigationController: UINavigationController
    let dismissAction = PublishSubject<Void>()
    let movieCode: String

    init(navigationController: UINavigationController, movieCode: String) {
        self.navigationController = navigationController
        self.movieCode = movieCode
    }

    override func start() -> Observable<Void> {
        let detailViewController = MovieDetailViewController()
        let detailViewModel = MovieDetailViewModel(
            coordinator: self,
            useCase: MovieDetailUseCase(
                movieDetailRepository: DefaultMovieDetailRepository()
            ),
            movieCode: self.movieCode
        )
        detailViewController.setViewModel(detailViewModel)
        self.navigationController.pushViewController(detailViewController, animated: true)

        return self.dismissAction.asObservable()
    }

    func dismiss() {
        self.dismissAction.onNext(())
    }
}
