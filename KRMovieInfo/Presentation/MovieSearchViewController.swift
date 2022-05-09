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
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var datasource: UICollectionViewDiffableDataSource<MovieListSection, MovieListItemWithImage>?
    private var snapshot = NSDiffableDataSourceSnapshot<MovieListSection, MovieListItemWithImage>()
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
        let input = MovieSearchViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
                .map { _ in }
        )
        let output = self.movieSearchViewModel?
            .transform(input: input)
        output?.itemFetched
            .drive(onNext: {
                var snapshot = NSDiffableDataSourceSnapshot<MovieListSection, MovieListItemWithImage>()
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
        self.datasource = UICollectionViewDiffableDataSource<MovieListSection, MovieListItemWithImage>(
            collectionView: self.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieListItemCell.reuseId,
                    for: indexPath
                ) as? MovieListItemCell else { fatalError() }

                DispatchQueue.main.async {
                    if indexPath == self.collectionView.indexPath(for: cell) {
                        cell.setContent(with: itemIdentifier.movieInfo)
                        cell.setImageData(with: itemIdentifier.imageData)
                    }
                }

                return cell
            }
        )
    }
}

extension MovieSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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
