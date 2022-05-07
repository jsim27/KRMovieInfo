//
//  DefaultNaverSearchRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/08.
//

import Foundation
import RxSwift

class DefaultNsverSearchRepository: NaverSearchRepository {

    let service = URLSessionService()

    func fetchNaverSearchResult(query: String, procudtionYearFrom: Int, productionYearTo: Int, page: Int, itemsPerPage: Int) -> Observable<NaverSearchResult?> {
        let request = NaverSearchRequest(query: query, procudtionYearFrom: procudtionYearFrom, productionYearTo: productionYearTo, page: page, itemsPerPage: itemsPerPage)
        let response = service.execute(request: request)
        
        return response.map { $0.toDomain() }
    }
}

private extension NaverSearchResponse {

    func toDomain() -> NaverSearchResult? {
        guard let first = self.items.first else { return nil }
        return NaverSearchResult(
            title: first.title,
            link: first.link,
            image: first.image,
            subtitle: first.subtitle,
            pubDate: first.pubDate,
            director: first.director,
            actor: first.actor,
            userRating: first.userRating
        )
    }
}
