//
//  URLSessionService+Ext.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation
import RxSwift

extension Reactive where Base: URLSessionService {
    func execute<T: APIRequest>(request: T) -> Observable<T.APIResponse> {
        return Observable.create { emitter in
            guard let request = request.urlRequest else {
                emitter.onError(NetworkError.invalidRequest)
                return Disposables.create()
            }
            let task = self.base.session
                .dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        emitter.onError(NetworkError.error(error))
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse else {
                        emitter.onError(NetworkError.invalidResponse)
                        return
                    }

                    guard (200...299) ~= httpResponse.statusCode else {
                        emitter.onError(NetworkError.statusError(code: httpResponse.statusCode))
                        return
                    }

                    guard let data = data else {
                        emitter.onError(NetworkError.invalidData)
                        return
                    }

                    guard let parsed = try? JSONDecoder().decode(T.APIResponse.self, from: data) else {
                        emitter.onError(NetworkError.parsingFailed)
                        return
                    }

                    emitter.onNext(parsed)
                    emitter.onCompleted()
                }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }

    }
}
