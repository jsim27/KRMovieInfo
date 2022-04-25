//
//  DefaultMovieListRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/25.
//

import Foundation
import RxSwift

class DefaultMovieListRepository: MovieListRepository {
    // url세션은 매번 생성하는것과 사용할 때마다 생성하는 것 중 뭐가 맞을까? / 유지비용vs생성비용
    func fetch(_ title: String) -> Observable<MovieList> {

    }

}
