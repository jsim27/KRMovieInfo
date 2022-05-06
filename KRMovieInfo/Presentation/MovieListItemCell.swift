//
//  MovieListItemCell.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/07.
//

import UIKit

class MovieListItemCell: UICollectionViewCell {

    static let reuseId = "MovieListItemCell"

    private let viewModel = MovieSearchViewModel()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "circle"))

        return imageView
    }()

    let stackView = UIStackView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(with movieListItem: MovieListItem) {
        self.titleLabel.text = movieListItem.title
        self.directorLabel.text = movieListItem.directors.joined(separator: ", ")
    }

    private func configure() {

        self.configureHeirarchy()
        self.configureConstraint()
        self.configureContentView()
    }
    private func configureContentView() {
        self.contentView.layer.borderWidth = 0.1
        self.contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    private func configureHeirarchy() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.directorLabel)
    }
    private func configureConstraint() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
