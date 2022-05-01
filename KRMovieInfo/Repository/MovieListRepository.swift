//
//  MovieListRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation
import RxSwift

protocol MovieListRepository {
    
    func fetch(title: String) -> Observable<MovieList>
    
    func fetch(director: String) -> Observable<MovieList>
}
