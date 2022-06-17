//
//  MovieSearchCoordinator.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/17.
//

import UIKit
import RxSwift

class MovieSearchCoordinator: Coordinator<Void> {

    let identifier = UUID()
    let navigationController: UINavigationController
    let tabBarController: UITabBarController

    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController

    }

    override func start() -> Observable<Void> {
        Observable.create { _ in
            let movieSearchViewController = MovieSearchViewController()
            let movieSearchViewModel = MovieSearchViewModel(
                coordinator: self,
                useCase: MovieListUseCase(
                    movieListRepository: DefaultMovieListRepository(),
                    naverSearchRepository: DefaultNaverSearchRepository()
                )
            )
            movieSearchViewController.setViewModel(movieSearchViewModel)
            self.tabBarController.setViewControllers([movieSearchViewController], animated: true)

            return Disposables.create()
        }
    }

    func coordinateToMovieDetail(movieCode: String) -> Observable<Void> {
        return self.coordinate(
            to: DetailViewCoordinator(
                navigationController: self.navigationController
            )
        )
    }
}
