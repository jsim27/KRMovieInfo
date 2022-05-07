//
//  APIRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

protocol APIRequest {

    associatedtype Response: APIResponse

    var base: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var urlComponents: URLComponents? { get }
}

extension APIRequest {

    var url: URL? {

        return self.urlComponents?.url
    }

    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        self.header?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        return request
    }
}

enum APIKeyPriority {
    case main
    case sub
}

enum HTTPMethod: String {
    case GET, POST, PATCH, DELETE
}
