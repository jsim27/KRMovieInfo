//
//  MockMovieListRepository.swift
//  KRMovieInfoTests
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation
import RxSwift

class MockMovieListRepository: MockMovieListRepository {
    static let MockMovieListData = MovieList(
        title: "제목",
        titleEn: "title",
        prductionYear: "2022",
        openDate: "20220420",
        movieType: "극영화",
        productionState: .release,
        nationAll: "한국",
        genreAll: "공포",
        representingNation: "한국",
        representingGenre: "공포",
        directors: [Director(name: "히치콕")],
        companys: [Company(companyName: "Paramount")]
    )

    func fetch(_ title: String) -> Observable<MovieList> {
        return Observable.create { emitter in
            emitter.onNext(Self.MockMovieListData)
            return Disposables.create()
        }
    }
}
