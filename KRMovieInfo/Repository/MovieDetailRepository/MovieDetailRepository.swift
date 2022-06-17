//
//  MovieDetailRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation
import RxSwift

protocol MovieDetailRepository {

    func fetchMovieDetail(code: String) -> Observable<MovieDetailEntity>
}
