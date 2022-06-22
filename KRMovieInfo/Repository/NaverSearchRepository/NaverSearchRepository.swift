//
//  NaverSearchRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/08.
//

import Foundation
import RxSwift

protocol NaverSearchRepository {

    func fetchNaverSearchResult(
        query: String,
        procudtionYearFrom: Int,
        productionYearTo: Int,
        page: Int,
        itemsPerPage: Int
    ) -> Observable<[NaverSearchResult]>
}
