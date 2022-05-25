//
//  DefaultNaverSearchRepository.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/08.
//

import Foundation
import RxSwift

class DefaultNaverSearchRepository: NaverSearchRepository {

    let service = URLSessionService()
    var num: Int = 0

    func fetchNaverSearchResult(
        query: String,
        procudtionYearFrom: Int,
        productionYearTo: Int,
        page: Int,
        itemsPerPage: Int
    ) -> Observable<[NaverSearchResult]> {
        let request = NaverSearchRequest(
            query: query,
            procudtionYearFrom: procudtionYearFrom,
            productionYearTo: productionYearTo,
            page: page,
            itemsPerPage: itemsPerPage
        )
        let response = service.rx.execute(request: request)
        return response.map { $0.toDomain() }
    }
}

private extension NaverSearchResponse {

    func toDomain() -> [NaverSearchResult] {
        return self.items.map { item in
            NaverSearchResult(
                title: item.title,
                link: item.link,
                image: item.image,
                subtitle: item.subtitle,
                pubDate: item.pubDate,
                director: item.director.trimmingCharacters(in: ["|"]),
                actor: item.actor,
                userRating: item.userRating
            )
        }
    }
}
