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

    func fetchMovieList(title: String) -> Observable<[MovieListItem]> {
        let request = MovieListRequest(query: ["movieNm": title])
        let response = service.execute(request: request)

        return response.map { $0.toDomain() }
    }

    func fetchMovieList(director: String) -> Observable<[MovieListItem]> {
        let request = MovieListRequest(query: ["directorNm": director])
        let response = service.execute(request: request)

        return response.map { $0.toDomain() }
    }
}

private extension MovieListResponse {

    func toDomain() -> [MovieListItem] {
        return self.movieList.map {
            return MovieListItem(
                title: $0.title,
                titleEn: $0.titleEn,
                prductionYear: $0.prductionYear,
                openDate: $0.openDate,
                movieType: $0.movieType.rawValue,
                productionState: $0.productionState.rawValue,
                nationAll: $0.nationAll,
                genreAll: $0.genreAll,
                representingNation: $0.representingNation,
                representingGenre: $0.representingGenre,
                directors: $0.directors.map { $0.name },
                companys: $0.companys.map { $0.companyName }
            )
        }
    }
}
