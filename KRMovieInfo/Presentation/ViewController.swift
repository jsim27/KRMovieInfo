//
//  ViewController.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/04/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MovieListUsecase(movieListRepository: DefaultMovieListRepository()).fetchMovieList(director: "봉준호")
            .subscribe { event in
                print(event)
            }
    }
}
