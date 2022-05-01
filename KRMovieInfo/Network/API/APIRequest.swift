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
    var method: HTTPMethod { get }
    var query: [String: Any] { get }
}

extension APIRequest {
    var url: URL? {
        var urlComponents = URLComponents(string: self.base)
        urlComponents?.queryItems = self.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return urlComponents?.url
    }

    var request: URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        return request
    }
}

enum HTTPMethod: String {
    case GET, POST, PATCH, DELETE
}
