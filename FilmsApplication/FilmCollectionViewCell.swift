//
//  FilmCollectionViewCell.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 20.07.2023.
//


import UIKit

@available(iOS 16.0, *)
class FilmCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
        return title
    }()
    
    private let posterImageView = UIImageView()
    
    private let yearLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .preferredFont(forTextStyle: .footnote)
        return title
    }()
    
    private let genreLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .preferredFont(forTextStyle: .footnote)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 5
        posterImageView.layer.cornerRadius = 5
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        contentView.addSubview(genreLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(titleLabel)
        

        NSLayoutConstraint.activate([
            
            // poster of the film
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            // title of the film
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            // year of the film
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            // genre of the film
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            genreLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 1),
            
            
            

        ])

    }
    
    func configure(with film: Film) {
        posterImageView.image = UIImage(named: film.posterUrl)
        titleLabel.text = film.nameEn
        yearLabel.text = String(film.year) + ", "
        genreLabel.text = film.genres[0].genre

    }
}

