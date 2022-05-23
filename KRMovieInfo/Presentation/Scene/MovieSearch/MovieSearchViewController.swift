//
//  MovieSearchViewController.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/03.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSearchViewController: UIViewController {

    private var movieSearchViewModel: MovieSearchViewModel?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var datasource: UICollectionViewDiffableDataSource<MovieListSection, MovieListItemWithAsyncImage>?
    private var snapshot = NSDiffableDataSourceSnapshot<MovieListSection, MovieListItemWithAsyncImage>()
    private let searchController = UISearchController()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.binding()
    }
}

extension MovieSearchViewController {

    func setViewModel(_ viewModel: MovieSearchViewModel) {
        self.movieSearchViewModel = viewModel
    }
}

extension MovieSearchViewController {

    private func binding() {
        let viewWillAppear = self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in }

        let searchBarDidChange = self.searchController.searchBar.rx.text
            .asObservable()
            .compactMap { $0 }
            .distinctUntilChanged()

        let searchBarScopeIndex = self.searchController.searchBar.rx.selectedScopeButtonIndex
            .asObservable()

        let input = MovieSearchViewModel.Input(
            viewWillAppear: viewWillAppear,
            searchBarDidChange: searchBarDidChange,
            searchBarScopeIndex: searchBarScopeIndex
        )

        let output = self.movieSearchViewModel?
            .transform(input: input)

        output?.itemFetched
            .drive(onNext: {
                var snapshot =
                NSDiffableDataSourceSnapshot<MovieListSection, MovieListItemWithAsyncImage>()
                snapshot.appendSections([.main])
                snapshot.appendItems($0, toSection: .main)
                self.snapshot = snapshot
                self.datasource?.apply(self.snapshot)
            })
            .disposed(by: self.disposeBag)
    }

    private func configure() {
        configureView()
        configureHeirarchicy()
        configureConstraint()
        configureCollectionView()
        configureSearchController()
    }

    private func configureView() {
        self.view.backgroundColor = .white
        self.title = "영화 검색"
        self.tabBarController?.title = "영화 검색"
    }

    private func configureHeirarchicy() {
        self.view.addSubview(self.collectionView)
    }

    private func configureConstraint() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func configureCollectionView() {
        self.collectionView.register(MovieListItemCell.self, forCellWithReuseIdentifier: MovieListItemCell.reuseId)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self.datasource
        self.configureCollectionviewDiffableDatasource()
    }

    private func configureCollectionviewDiffableDatasource() {
        self.datasource =
        UICollectionViewDiffableDataSource<MovieListSection, MovieListItemWithAsyncImage>(
            collectionView: self.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieListItemCell.reuseId,
                    for: indexPath
                ) as? MovieListItemCell else { fatalError() }

                DispatchQueue.main.async {
                    if indexPath == self.collectionView.indexPath(for: cell) {
                        cell.setContent(with: itemIdentifier.movieInfo)
                    }
                }

                itemIdentifier.imageData
                    .map {
                        guard let data = $0 else {
                            return UIImage(systemName: "questionmark.square")
                        }
                        return UIImage(data: data)
                    }
                    .asDriver(onErrorJustReturn: UIImage(systemName: "exclamationmark.circle.fill"))
                    .filter({ _ in
                        indexPath == self.collectionView.indexPath(for: cell)
                    })
                    .drive(cell.rx.thumbnailImage)
                    .disposed(by: self.disposeBag)
                
                return cell
            }
        )
    }

    private func configureSearchController() {
        self.searchController.searchBar.scopeButtonTitles = [
            "영화명", "감독명"
        ]
        self.tabBarController?.navigationItem.searchController = self.searchController
    }
}

extension MovieSearchViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? MovieListItemCell else { fatalError() }

        cell.disposeBag = DisposeBag()
    }
}

extension MovieSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 7)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
}

enum MovieListSection {
    case main
}
