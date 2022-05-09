//
//  MovieSearchViewModel.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/03.
//

import Foundation
import RxSwift
import RxCocoa

class MovieSearchViewModel: ViewModelProtocol {

    private let movieSearchUseCase = MovieListUsecase(movieListRepository: DefaultMovieListRepository())
    private let imageSearchUseCase = NaverSearchUsecase(naverSearchRepository: DefaultNaverSearchRepository())

    struct Input {
        let viewWillAppear: Observable<Void>
    }
    struct Output {
        let itemFetched: Driver<[MovieListItemWithImage]>
    }

    func transform(input: Input) -> Output {

        let itemFetched: Driver<[MovieListItemWithImage]> = input.viewWillAppear
            .flatMap {
                self.movieSearchUseCase.fetchMovieList(director: "박찬욱", page: 1, itemsPerPage: 100)
            }
            .map { items in
                items.filter { item in
                    !item.genreAll.contains("성인물(에로)")
                }
                .map { item in
                    let naverSearchResult = self.imageSearchUseCase.fetchNaverSearchResult(
                        query: item.title,
                        procudtionYearFrom: Int(item.productionYear) ?? 0,
                        productionYearTo: (Int(item.openDate.prefix(4)) ?? 3000)
                    )
                        .retry { error in
                            error.flatMap { _ in
                                return Observable<Int>.timer(.milliseconds(100), scheduler: MainScheduler.instance)
                            }
                        }
                    let imageData = naverSearchResult
                        .map { (result) -> Data? in
                            let naverResult = result.count == 1 ? result : result.filter {
                                return item.directors.contains($0.director.trimmingCharacters(in: ["|"]))
                            }
                            guard let urlString = naverResult.first?.image else { return nil }
                            guard let url = URL(string: urlString) else { return nil }

                            return try? Data(contentsOf: url)
                        }
                    return MovieListItemWithImage(movieInfo: item, imageData: imageData)
                }
            }
            .asDriver(onErrorJustReturn: [])

        return Output(itemFetched: itemFetched)
    }
}

struct MovieListItemWithImage: Hashable {
    static func == (lhs: MovieListItemWithImage, rhs: MovieListItemWithImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id = UUID()
    var movieInfo: MovieListItem
    var imageData: Observable<Data?>
}
