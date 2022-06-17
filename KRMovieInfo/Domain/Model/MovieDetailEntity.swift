//
//  MovieDetailEntity.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/17.
//

import Foundation

struct MovieDetailEntity: Decodable {
    
    let movieCode, title, titleEn, titleOriginal: String
    let showTime, prductionYear, openDate, productionState: String
    let movieType: String
    let nations: String
    let genres: String
    let directors: String
    let actors: String
    let companys: String
    let audits, staffs: String
}
