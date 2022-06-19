//
//  MovieSearchAPIInfoOwner.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/19.
//

import Foundation

protocol MovieSearchAPIInfoOwner: MovieAPIInfoOwner {

    var path: String { get }
}

extension MovieSearchAPIInfoOwner {

    var path: String {
        return "searchMovieList.json"
    }
}
