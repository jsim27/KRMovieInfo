//
//  MovieDetailViewController.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/06/16.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private var viewModel: MovieDetailViewModel?

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

    }

    func configure() {
        configureHierarchy()
        configureConstraint()
    }

    func configureHierarchy() {

    }

    func configureConstraint() {

    }

}
