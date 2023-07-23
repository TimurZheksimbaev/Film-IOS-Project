
import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 18, weight: .bold, width: .standard)
        return title
    }()
    
    private let posterImageView = UIImageView()
    
    private let durationLabel: UILabel = {
        let duration = UILabel()
        duration.textAlignment = .center
        duration.font = UIFont.systemFont(ofSize: 12)
        return duration
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
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
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        contentView.addSubview(durationLabel)
        contentView.addSubview(titleLabel)
        

        NSLayoutConstraint.activate([
            
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            
            
            durationLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 1),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            
            
            titleLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            

        ])

    }
    
    func configure(with film: Film) {
        posterImageView.image = UIImage(named: film.posterUrl)
        titleLabel.text = film.nameEn
        durationLabel.text = film.filmLength

    }
}
