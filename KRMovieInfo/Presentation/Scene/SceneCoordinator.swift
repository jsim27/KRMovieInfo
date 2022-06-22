//
//  SceneCoordinator.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/22.
//

import UIKit
import RxSwift

class SceneCoordinator: Coordinator<Void> {
    let identifier = UUID()
    let navigationController: UINavigationController
    let tabBarController = UITabBarController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {
        Observable.create { _ in
            let movieSearchViewController = MovieSearchViewController()
            let movieSearchViewModel = MovieSearchViewModel(
                coordinator: self,
                useCase: MovieListUsecase(
                    movieListRepository: DefaultMovieListRepository(),
                    naverSearchRepository: DefaultNaverSearchRepository()
                )
            )
            movieSearchViewController.setViewModel(movieSearchViewModel)
            self.tabBarController.setViewControllers([movieSearchViewController], animated: true)
            self.navigationController.setViewControllers([self.tabBarController], animated: true)
            return Disposables.create()
        }
    }
}
