//
//  ViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 19.07.2023.
//

import UIKit


class HomeViewController: UIViewController {
    
    let networkManager = NetworkManger.shared
    
    // MARK: titles
    let popMoviesTitle: UILabel = {
        let title = UILabel()
        title.text = "Popular Movies"
        title.font = .systemFont(ofSize: 30, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    // films from API
    var topFilms = [Film]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // Create a UICollectionView with a horizontal scroll layout
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 250) // Set the desired fixed size
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    

    
    // MARK: main function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        networkManager.getTopMovies() { result in
            switch result {
            case .success(let success):
                self.topFilms.append(contentsOf: success.films ?? [])
                
            case .failure(let failure):
                print(failure)
            }
        }

        
        view.addSubview(popMoviesTitle)
        view.addSubview(collectionView)
        
        
        setupLayout()
    }
    
    // MARK: setting constraints
    func setupLayout() {
        
        
        NSLayoutConstraint.activate([
            
            popMoviesTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            popMoviesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
  
            
            collectionView.topAnchor.constraint(equalTo: popMoviesTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height - 215)
            
        ])
    }
    
}


// MARK: collection of films
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(topFilms.count)
        return topFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let film = topFilms[indexPath.item]
        if film.nameRu == nil {
            return UICollectionViewCell()
        }
        
        cell.configure(with: film)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellFilm = topFilms[indexPath.item]
        let openCell = DetailViewController()
        openCell.configure(movie: cellFilm)
        navigationController?.pushViewController(openCell, animated: true)
        
    }
}
