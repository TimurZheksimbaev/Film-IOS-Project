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
    
    
    let popTVShowsTitle: UILabel = {
        let title = UILabel()
        title.text = "Popular TV Shows"
        title.font = .systemFont(ofSize: 30, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
//    var films: [Film] = TopFilms.example.films
    static var tvshows: [TVShow] = TVShow.example
    
    // Create a UICollectionView with a horizontal scroll layout
    private lazy var filmCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 250) // Set the desired fixed size
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    private lazy var tvScrollView = UIScrollView()
    
    
    // MARK: buttons
    lazy var buttonMovies: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.setTitle("Movies", for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var buttonTVShows: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.setTitle("TV Shows", for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonMovies, buttonTVShows])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    
    
    
    // MARK: main function
    //    var scrollView: UIScrollView!
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        view.backgroundColor = .systemBackground
    //
    //        // Assuming you have an array of TVShow instances, or you can create one
    //        let tvShows = [
    //            TVShow(id: 1, name: "TV Show 1", year: 2023, image: "tv_show_image_1"),
    //            TVShow(id: 2, name: "TV Show 2", year: 2022, image: "tv_show_image_2"),
    //            TVShow(id: 3, name: "TV Show 3", year: 2021, image: "tv_show_image_3")
    //            // Add more TVShow instances here...
    //        ]
    //
    //        // Create and configure the UIScrollView
    //        scrollView = UIScrollView()
    //        scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(scrollView)
    //
    //        // Set up constraints for the scrollView to fill the entire view
    //        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    //        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    //        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    //        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    //
    //        // Set the scroll direction to horizontal
    //        scrollView.isPagingEnabled = true
    //
    //        var previousView: UIView?
    //        for tvShow in tvShows {
    //            // Create a container view for each TV show to hold its elements
    //            let containerView = UIView()
    //            containerView.translatesAutoresizingMaskIntoConstraints = false
    //            scrollView.addSubview(containerView)
    //
    //            // Create and configure the UIImageView for the TV show image
    //            let tvShowImageView = UIImageView()
    //            tvShowImageView.translatesAutoresizingMaskIntoConstraints = false
    //            tvShowImageView.image = UIImage(named: tvShow.image)
    //            tvShowImageView.contentMode = .scaleAspectFit
    //            containerView.addSubview(tvShowImageView)
    //
    //            // Create and configure the UILabel for the TV show name
    //            let nameLabel = UILabel()
    //            nameLabel.translatesAutoresizingMaskIntoConstraints = false
    //            nameLabel.text = tvShow.name
    //            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    //            containerView.addSubview(nameLabel)
    //
    //            // Create and configure the UILabel for the TV show year
    //            let yearLabel = UILabel()
    //            yearLabel.translatesAutoresizingMaskIntoConstraints = false
    //            yearLabel.text = "\(tvShow.year)"
    //            yearLabel.font = UIFont.systemFont(ofSize: 16)
    //            containerView.addSubview(yearLabel)
    //
    //            // Set up constraints for the subviews to position them horizontally within the containerView
    //            NSLayoutConstraint.activate([
    //                containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
    //                containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
    //                containerView.widthAnchor.constraint(equalTo: view.widthAnchor), // Ensure each container view is as wide as the screen
    //
    //                tvShowImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
    //                tvShowImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
    //                tvShowImageView.widthAnchor.constraint(equalToConstant: 200),
    //                tvShowImageView.heightAnchor.constraint(equalToConstant: 200),
    //
    //                nameLabel.topAnchor.constraint(equalTo: tvShowImageView.bottomAnchor, constant: 10),
    //                nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
    //
    //                yearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
    //                yearLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
    //                yearLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    //            ])
    //
    //            // Update the containerView's leading anchor based on the previous view's trailing anchor
    //            if let prevView = previousView {
    //                containerView.leadingAnchor.constraint(equalTo: prevView.trailingAnchor).isActive = true
    //            } else {
    //                containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    //            }
    //
    //            previousView = containerView
    //        }
    //
    //        // Set the scrollView content size to fit all elements horizontally
    //        if let lastView = previousView {
    //            scrollView.contentSize = CGSize(width: lastView.frame.maxX, height: scrollView.frame.height)
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(buttonStack)
        
        view.addSubview(popMoviesTitle)
        view.addSubview(filmCollectionView)
        
        view.addSubview(popTVShowsTitle)
        view.addSubview(tvScrollView)
        
//        setupScrollView()
        networkManager.getTopMovies() { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let movie):
                print(movie)
            }
        }
        
        
        setupLayout()
    }
    
    
    
//    func setupScrollView() {
//        var previousView: UIView?
//
//        for tvshow in tvshows {
//            // Create and configure the UIImageView for the TV show image
//            let tvShowImageView = UIImageView()
//            tvShowImageView.translatesAutoresizingMaskIntoConstraints = false
//            tvShowImageView.image = UIImage(named: tvShow.image)
//            tvShowImageView.contentMode = .scaleAspectFit
//            scrollView.addSubview(tvShowImageView)
//
//            // Create and configure the UILabel for the TV show name
//            let nameLabel = UILabel()
//            nameLabel.translatesAutoresizingMaskIntoConstraints = false
//            nameLabel.text = tvShow.name
//            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
//            scrollView.addSubview(nameLabel)
//
//            // Create and configure the UILabel for the TV show year
//            let yearLabel = UILabel()
//            yearLabel.translatesAutoresizingMaskIntoConstraints = false
//            yearLabel.text = "\(tvShow.year)"
//            yearLabel.font = UIFont.systemFont(ofSize: 16)
//            scrollView.addSubview(yearLabel)
//
//            // Set up constraints for the subviews to position them vertically
//            NSLayoutConstraint.activate([
//                tvShowImageView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? scrollView.topAnchor, constant: 20),
//                tvShowImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//                tvShowImageView.widthAnchor.constraint(equalToConstant: 200),
//                tvShowImageView.heightAnchor.constraint(equalToConstant: 200),
//
//                nameLabel.topAnchor.constraint(equalTo: tvShowImageView.bottomAnchor, constant: 20),
//                nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                nameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//
//                yearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
//                yearLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//                yearLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            ])
//
//            // Update the previousView to be the yearLabel for the next iteration
//            previousView = yearLabel
//        }
//    }
    
    
    
    func setupLayout() {
        
//        networkManager.getTopMovies()
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 40),
            
            
            popMoviesTitle.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            popMoviesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            filmCollectionView.topAnchor.constraint(equalTo: popMoviesTitle.bottomAnchor, constant: 8),
            filmCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            filmCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filmCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            popTVShowsTitle.topAnchor.constraint(equalTo: filmCollectionView.bottomAnchor, constant: 15),
            popTVShowsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            tvScrollView.topAnchor.constraint(equalTo: popTVShowsTitle.bottomAnchor, constant: 20),
            tvScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            
        ])
    }
    
}


//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return films.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        let film = films[indexPath.item]
//        cell.configure(with: film)
//
//        return cell
//    }
//}


