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

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        return imageView
    }()
    private let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15

        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private let titleVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3

        return stackView
    }()

    private let titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleMovieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    private let titleMovieInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .placeholderText
        return label
    }()

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

        output?.moviePoster
            .map(UIImage.init(data:))
            .bind(to: self.titlePosterImageView.rx.image, self.backgroundImageView.rx.image)
            .disposed(by: self.disposeBag)

        output?.movieTitle
            .bind(to: self.titleMovieNameLabel.rx.text)
            .disposed(by: self.disposeBag)

        output?.movieInfo
            .bind(to: self.titleMovieInfoLabel.rx.text)
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

    func configureTitleStackView() {

    }

    func configureHierarchy() {
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(self.containerScrollView)
        self.containerScrollView.addSubview(self.containerStackView)
        self.containerStackView.addArrangedSubview(self.titleStackView)
        self.titleStackView.addArrangedSubview(self.titlePosterImageView)
        self.titleStackView.addArrangedSubview(self.titleVerticalStackView)
        self.titleVerticalStackView.addArrangedSubview({
            let label = UILabel()
            label.font = .preferredFont(forTextStyle: .largeTitle)
            label.text = " "
            return label
        }())
        self.titleVerticalStackView.addArrangedSubview(self.titleMovieNameLabel)
        self.titleVerticalStackView.addArrangedSubview(self.titleMovieInfoLabel)
    }

    func configureConstraint() {
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backgroundImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//            self.backgroundImageView.heightAnchor.constraint(equalToConstant: 180)
        ])

        self.containerScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.containerScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.containerScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.containerScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerStackView.topAnchor.constraint(equalTo: self.containerScrollView.topAnchor),
            self.containerStackView.leadingAnchor.constraint(equalTo: self.containerScrollView.leadingAnchor),
            self.containerStackView.trailingAnchor.constraint(equalTo: self.containerScrollView.trailingAnchor),
            self.containerStackView.bottomAnchor.constraint(equalTo: self.containerScrollView.bottomAnchor),
            self.containerStackView.widthAnchor.constraint(equalTo: self.containerScrollView.widthAnchor)
        ])
        self.titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
        self.titleVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleVerticalStackView.widthAnchor.constraint(
                greaterThanOrEqualTo: self.view.widthAnchor,
                constant: -200
            )
        ])

        self.titlePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titlePosterImageView.widthAnchor.constraint(equalToConstant: 67),
            self.titlePosterImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
