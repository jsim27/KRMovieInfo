//
//  MovieListUsecase.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/24.
//

import Foundation
import RxSwift

class MovieListUsecase {

    let movieListRepository: MovieListRepository
    let naverSearchRepository: NaverSearchRepository

    init(movieListRepository: MovieListRepository, naverSearchRepository: NaverSearchRepository) {
        self.movieListRepository = movieListRepository
        self.naverSearchRepository = naverSearchRepository
    }

    func fetchMovieList(title: String, page: Int, itemsPerPage: Int) -> Observable<[MovieListItemWithAsyncImage]> {
        return self.movieListRepository.fetchMovieList(title: title, page: page, itemsPerPage: itemsPerPage)
            .map { items in
                self.filterAdultItems(items: items)
                    .map(self.movieListItemWithAsyncImage)
            }
    }

    func fetchMovieList(director: String, page: Int, itemsPerPage: Int) -> Observable<[MovieListItemWithAsyncImage]> {
        return self.movieListRepository.fetchMovieList(director: director, page: page, itemsPerPage: itemsPerPage)
            .map { items in
                self.filterAdultItems(items: items)
                    .map(self.movieListItemWithAsyncImage)
            }
    }

    private func fetchNaverSearchResult(movieInfo: MovieListItem) -> Observable<[NaverSearchResult]> {
        return self.naverSearchRepository.fetchNaverSearchResult(
            query: movieInfo.title,
            procudtionYearFrom: Int(movieInfo.productionYear) ?? 0,
            productionYearTo: Int(movieInfo.openDate.prefix(4)) ?? 3000,
            page: 1,
            itemsPerPage: 5
        )
    }

}

private extension MovieListUsecase {
    func filterAdultItems(items: [MovieListItem]) -> [MovieListItem] {
        return items.filter { $0.genreAll.contains("에로") == false }
    }

    func movieListItemWithAsyncImage(from item: MovieListItem) -> MovieListItemWithAsyncImage {
        let imageData = self.fetchNaverSearchResult(movieInfo: item)
            .map { (result) -> [NaverSearchResult] in
                guard result.count != 1 else { return result }
                return result.filter {
                    item.directors.contains($0.director)
                }
            }
            .flatMap(self.fetchImage)
            .retry { error in
                error.flatMap { _ in
                    Observable<Int>.timer(.milliseconds(100), scheduler: MainScheduler.instance)
                }
            }
        return MovieListItemWithAsyncImage(movieInfo: item, imageData: imageData)
    }

    func fetchImage(from result: [NaverSearchResult]) -> Observable<Data?> {
        return Observable.create { emitter in
            DispatchQueue.global().async {
                guard let urlString = result.first?.image,
                      let url = URL(string: urlString) else {
                    return
                }
                emitter.onNext(try? Data(contentsOf: url))
            }
            return Disposables.create()
        }
    }
}

struct MovieListItemWithAsyncImage: Hashable {
    static func == (lhs: MovieListItemWithAsyncImage, rhs: MovieListItemWithAsyncImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id = UUID()
    var movieInfo: MovieListItem
    var imageData: Observable<Data?>
}
