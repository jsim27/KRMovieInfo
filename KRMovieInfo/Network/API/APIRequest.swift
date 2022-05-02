//
//  APIRequest.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

protocol APIRequest {

    associatedtype APIResponse: Decodable

    var base: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    var query: [String: Any] { get }
}

extension APIRequest {

    var url: URL? {
        var urlComponents = URLComponents(string: self.base)
        urlComponents?.queryItems = self.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        urlComponents?.queryItems?.append(URLQueryItem(name: "key", value: self.apiKey))
        return urlComponents?.url
    }

    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

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
