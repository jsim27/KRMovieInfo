//
//  URLSessionService+Ext.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation
import RxSwift

extension URLSessionService {

    func execute<T: APIRequest>(request: T) -> Observable<T.APIResponse> {
        return Observable.create { emitter in
            let task = self.execute(request: request) { result in
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
