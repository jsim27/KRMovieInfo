//
//  URLSessionService.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation
import RxSwift

final class URLSessionService {

    let session = URLSession.shared

    func execute<T: APIRequest>(
        request: T,
        completion: @escaping (Result<T.APIResponse, NetworkError>) -> Void
    ) -> URLSessionDataTask? {

        guard let request = request.urlRequest else {
            completion(.failure(.invalidRequest))
            return nil
        }

        let task = self.session
            .dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(.failure(.error(error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
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

                guard let parsed = try? JSONDecoder().decode(T.APIResponse.self, from: data) else {
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
