//
//  URLSessionService+Ext.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation
import RxSwift

extension URLSessionService: ReactiveCompatible { }

extension Reactive where Base: URLSessionService {

    func execute<T: APIRequest>(request: T) -> Observable<T.Response> {
        return Observable.create { emitter in
            let task = base.execute(request: request) { result in
                switch result {
                case .success(let result):
                    emitter.onNext(result)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }

            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
