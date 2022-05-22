//
//  AppFlowCoordinator.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/22.
//

import UIKit
import RxSwift

class AppFlowCoordinator: Coordinator<Void> {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let navigationController = UINavigationController()
        let sceneCoordinator = SceneCoordinator(navigationController: navigationController)

        return self.coordinate(to: sceneCoordinator)
            .do(onSubscribe: { [weak self] in
                self?.window.rootViewController = navigationController
                self?.window.makeKeyAndVisible()
            })
    }
}
