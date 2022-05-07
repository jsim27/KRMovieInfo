//
//  MovieListItemCell.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/07.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListItemCell: UICollectionViewCell {

    static let reuseId = "MovieListItemCell"

    private let viewModel = MovieSearchViewModel()
    private var disposeBag: DisposeBag! = DisposeBag()

    let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10

        return stackView
    }()
    let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical

        return stackView
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "list.and.film"))
        imageView.tintColor = .systemGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()

    private let productionYearAndMovieTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()

    private let genreAndNationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = UIImage(systemName: "list.and.film")
    }

    func setContent(with movieListItem: MovieListItem) {
        self.titleLabel.text = movieListItem.title
        self.productionYearAndMovieTypeLabel.text = [
            movieListItem.productionYear,
            movieListItem.movieType
        ].joined(separator: " • ")
        self.genreAndNationLabel.text = [
            movieListItem.representingGenre,
            movieListItem.representingNation
        ].joined(separator: " • ")
        self.directorLabel.text = movieListItem.directors.joined(separator: ", ")

    }

    func setImageData(with imageData: Observable<Data?>) {
        imageData
            .map {
                guard let data = $0 else { return UIImage(systemName: "list.and.film") }
                return UIImage(data: data)
            }
            .debug()
            .asDriver(onErrorJustReturn: UIImage(systemName: "plus"))
            .drive((self.thumbnailImageView.rx.image))

            .disposed(by: self.disposeBag)
    }

    private func configure() {
        self.configureContentView()
        self.configureHeirarchy()
        self.configureConstraint()
    }
    private func configureContentView() {
        self.contentView.layer.borderWidth = 0.2
        self.contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    private func configureHeirarchy() {
        self.contentView.addSubview(self.hStackView)
        self.hStackView.addArrangedSubview(self.thumbnailImageView)
        self.vStackView.addArrangedSubview(self.titleLabel)
        self.vStackView.addArrangedSubview(self.productionYearAndMovieTypeLabel)
        self.vStackView.addArrangedSubview(self.directorLabel)
        self.hStackView.addArrangedSubview(self.vStackView)
    }
    private func configureConstraint() {
        self.hStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.hStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.hStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.hStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.hStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])

        self.thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.height * 0.75)
        ])
    }
}
