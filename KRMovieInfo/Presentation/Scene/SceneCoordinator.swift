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
        self.navigationController.setViewControllers([self.tabBarController], animated: true)
        return self.coordinateToMovieSearch()
            .withUnretained(self)
            .do(onNext: { coordinator, _ in
                coordinator.navigationController.setViewControllers([], animated: true)
            })
            .map { _ in }
    }

    func coordinateToMovieSearch() -> Observable<Void> {
        return self.coordinate(
            to: MovieSearchCoordinator(
                navigationController: self.navigationController,
                tabBarController: self.tabBarController
            )
        )
    }
}
