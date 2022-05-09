//
//  NaverSearchUsecase.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/08.
//

import Foundation
import RxSwift

class NaverSearchUsecase {

    let repository: NaverSearchRepository

    init(naverSearchRepository: NaverSearchRepository) {
        self.repository = naverSearchRepository
    }

    func fetchNaverSearchResult(
        query: String,
        procudtionYearFrom: Int,
        productionYearTo: Int
    ) -> Observable<NaverSearchResult?> {
        return self.repository.fetchNaverSearchResult(
            query: query,
            procudtionYearFrom: procudtionYearFrom,
            productionYearTo: productionYearTo,
            page: 1,
            itemsPerPage: 10
        )
    }
}
