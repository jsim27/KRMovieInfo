//
//  MovieDetailAPIInfoOwner.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/19.
//

import Foundation

protocol MovieDetailAPIInfoOwner: MovieAPIInfoOwner {

    var path: String { get }
}

extension MovieDetailAPIInfoOwner {

    var path: String {
        return "searchMovieInfo.json"
    }
}
