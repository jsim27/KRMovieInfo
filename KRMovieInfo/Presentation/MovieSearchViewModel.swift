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
    private let imageSearchUseCase = NaverSearchUsecase(naverSearchRepository: DefaultNsverSearchRepository())

    struct Input {
        let viewWillAppear: Observable<Void>
    }
    struct Output {
        let itemFetched: Driver<[MovieListItemWithImage]>
    }

    func transform(input: Input) -> Output {

        let itemFetched: Driver<[MovieListItemWithImage]> = input.viewWillAppear
            .flatMap {
                self.movieSearchUseCase.fetchMovieList(title: "", page: 1, itemsPerPage: 100)
            }
            .map { items in
                items.map { item in
                    let naverSearchResult = self.imageSearchUseCase.fetchNaverSearchResult(
                        query: item.title,
                        procudtionYearFrom: Int(item.productionYear) ?? 0,
                        productionYearTo: Int(item.productionYear) ?? 3000
                    )
                    let imageData = naverSearchResult
                        .map { (item) -> Data? in
                            guard let urlString = item?.image else { return nil }
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
