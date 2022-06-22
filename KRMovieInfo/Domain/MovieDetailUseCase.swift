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

    func fetchPosterData(movieInfo: MovieDetailEntity) -> Observable<Data> {
        self.fetchNaverSearchResult(movieInfo: movieInfo)
            .map { (result) -> [NaverSearchResult] in
                guard result.count != 1 else { return result }
                return result.filter {
                    movieInfo.directors.contains($0.director)
                }
            }
            .flatMap(self.fetchImage)
            .compactMap { $0 }
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


    func fetchImage(from result: [NaverSearchResult]) -> Observable<Data?> {
        return Observable.create { emitter in
            let task = DispatchWorkItem {
                guard let urlString = result.first?.image,
                      let url = URL(string: urlString) else {
                    emitter.onNext(nil) // TODO: onError로 변경
                    emitter.onCompleted()
                    return
                }
                emitter.onNext(try? Data(contentsOf: url))
                emitter.onCompleted()
            }

            DispatchQueue.global().async(execute: task)

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
