
import UIKit
import SwiftUI

// MARK: film cell
class FilmCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 18, weight: .bold)
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
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 1),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -1),
            
            
            // year of the film
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            yearLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 1),
            
            // genre of the film
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            genreLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 1),
            
            
            
            
        ])
        
    }
    
    func configure(with film: Film) {
        
        
        DispatchQueue.global().async { [weak self] in
            
            
            if let data = try? Data(contentsOf: URL(string: film.posterUrl!)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self!.posterImageView.image = image
                    }
                }
            }
        }
        
        titleLabel.text = film.nameRu!
        yearLabel.text = String(film.year ?? "") + ", "
        genreLabel.text = film.genres![0].genre!
        
    }
}
