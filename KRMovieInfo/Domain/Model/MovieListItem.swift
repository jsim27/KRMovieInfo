//
//  MovieListItem.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation

struct MovieListItem: Hashable {

    let code: String
    let title, titleEn, productionYear: String
    let openDate: String
    let movieType: String
    let productionState: String
    let nationAll, genreAll, representingNation, representingGenre: String
    let directors: [String]
    let companys: [String]
}
