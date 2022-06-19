//
//  MovieDetailViewController.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {

    private var viewModel: MovieDetailViewModel?
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        configure()
        binding()
    }

    func setViewModel(_ viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
}

private extension MovieDetailViewController {

    func binding() {
        let viewWillAppear = self.rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in }
            .asObservable()
        let input = MovieDetailViewModel.Input(viewWillAppear: viewWillAppear)

        let output = self.viewModel?.transform(input: input)

        output?.navigationTitle
            .bind(to: self.rx.title)
            .disposed(by: self.disposeBag)
    }

    func configure() {
        configureView()
        configureHierarchy()
        configureConstraint()
    }

    func configureView() {
        self.view.backgroundColor = .white
    }

    func configureHierarchy() {

    }

    func configureConstraint() {

    }

}
