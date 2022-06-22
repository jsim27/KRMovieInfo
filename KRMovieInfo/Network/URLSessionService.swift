//
//  URLSessionService.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation
import RxSwift

final class URLSessionService {

    private let session = URLSession.shared
    private let cache: URLCache = {
        let cacheDirectory = (
            NSSearchPathForDirectoriesInDomains(
            .cachesDirectory, .userDomainMask, true)[0] as String
        )
            .appendingFormat(Bundle.main.bundleIdentifier ?? "cache")

        return URLCache(
            memoryCapacity: 300 * 1024 * 1024,
            diskCapacity: 300 * 1024 * 1024,
            diskPath: cacheDirectory
        )
    }()

    func execute<T: APIRequest>(
        request: T,
        isCacheNeeded: Bool,
        completion: @escaping (Result<T.Response, NetworkError>) -> Void
    ) -> URLSessionDataTask? {

        guard let request = request.urlRequest else {
            completion(.failure(.invalidRequest))
            return nil
        }

        if let cachedResponse = self.cache.cachedResponse(for: request) {
            guard let parsed = try? JSONDecoder().decode(
                T.Response.self,
                from: cachedResponse.data
            ) else {
                completion(.failure(.parsingFailed))
                return nil
            }

            completion(.success(parsed))
            return nil
        }

        let task = self.session
            .dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(.failure(.error(error)))
                    return
                }

                guard let urlResponse = response else {
                    completion(.failure(.invalidResponse))
                    return
                }

                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }

                guard (200...299) ~= httpResponse.statusCode else {
                    completion(.failure(.statusError(code: httpResponse.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }

                self.cache.storeCachedResponse(
                    CachedURLResponse(
                        response: urlResponse,
                        data: data
                    ),
                    for: request
                )

                guard let parsed = try? JSONDecoder().decode(
                    T.Response.self,
                    from: data
                ) else {
                    completion(.failure(.parsingFailed))
                    return
                }

                completion(.success(parsed))
            }

        task.resume()

        return task
    }
}

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case invalidData
    case parsingFailed
    case statusError(code: Int)
    case error(_ error: Error?)
}
