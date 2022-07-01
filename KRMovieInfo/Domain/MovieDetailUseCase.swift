//
//  MovieDetailUseCase.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import Foundation
import RxSwift

class MovieDetailUseCase {

    let movieDetailRepository: MovieDetailRepository
    let naverSearchRepository: NaverSearchRepository

    init(movieDetailRepository: MovieDetailRepository, naverSearchRepository: NaverSearchRepository) {
        self.movieDetailRepository = movieDetailRepository
        self.naverSearchRepository = naverSearchRepository
    }

    func fetchMovieDetail(code: String) -> Observable<MovieDetailEntity> {
        return self.movieDetailRepository.fetchMovieDetail(code: code)
    }

    func fetchNaverMovieInfo(movieInfo: MovieDetailEntity) -> Observable<NaverSearchResult> {
        return self.fetchNaverSearchResult(movieInfo: movieInfo)
            .map { (result) -> [NaverSearchResult] in
                guard result.count != 1 else { return result }
                return result.filter {
                    movieInfo.directors.contains($0.director)
                }
            }
            .compactMap{ $0.first }
    }

    private func fetchNaverSearchResult(movieInfo: MovieDetailEntity) -> Observable<[NaverSearchResult]> {
        return self.naverSearchRepository.fetchNaverSearchResult(
            query: movieInfo.title,
            procudtionYearFrom: Int(movieInfo.prductionYear) ?? 0,
            productionYearTo: Int(movieInfo.openDate.prefix(4)) ?? 3000,
            page: 1,
            itemsPerPage: 5
        )
    }

    func fetchImage(from result: NaverSearchResult) -> Observable<Data> {
        return Observable.create { emitter in
            let task = DispatchWorkItem {
                let urlString = result.image
                guard let url = URL(string: urlString),
                      let posterData = try? Data(contentsOf: url) else {
                    return
                }
                emitter.onNext(posterData)
                emitter.onCompleted()
            }

            DispatchQueue.global().async(execute: task)

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
