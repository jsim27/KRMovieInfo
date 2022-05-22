//
//  Coordinator.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/21.
//

import Foundation
import RxSwift

protocol IdentifiableCoordinator: AnyObject {
    var id: UUID { get }
}

class Coordinator<CoordinationResult>: IdentifiableCoordinator {
    var childCoordinators = [UUID: IdentifiableCoordinator]()
    let id = UUID()

    func store(coordinator: IdentifiableCoordinator) {
        self.childCoordinators.updateValue(coordinator, forKey: coordinator.id)
    }

    func release(coordinator: IdentifiableCoordinator) {
        self.childCoordinators.removeValue(forKey: coordinator.id)
    }

    func coordinate<T>(to coordinator: Coordinator<T>) -> Observable<T> {
        self.store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator)
            })
    }

    func start() -> Observable<CoordinationResult> {
        return Observable.never()
    }
}
