//
//  MovieSearchViewController.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/03.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var movieSearchViewModel: MovieSearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MovieSearchViewController {

    func setViewModel(_ viewModel: MovieSearchViewModel) {
        self.movieSearchViewModel = viewModel
    }
}
