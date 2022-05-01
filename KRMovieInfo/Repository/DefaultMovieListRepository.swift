//
//  DefaultMovieListRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/25.
//

import Foundation
import RxSwift

class DefaultMovieListRepository: MovieListRepository {

    let service = URLSessionService()
    
    func fetch(title: String) -> Observable<MovieList> {
        
    }

    func fetch(director: String) -> Observable<MovieList> {

    }

}
