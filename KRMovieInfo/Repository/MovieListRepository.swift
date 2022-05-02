//
//  MovieListRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation
import RxSwift

protocol MovieListRepository {

    func fetchMovieList(title: String) -> Observable<[MovieListItem]>

    func fetchMovieList(director: String) -> Observable<[MovieListItem]>
}
