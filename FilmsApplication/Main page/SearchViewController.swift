//
//  SearchViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 19.07.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    var films = [Film]()
    let networkManager = NetworkManger.shared
    
    // MARK: texts
    var searchText: UILabel = {
        var text = UILabel()
        text.text = "Search for a film"
        text.font = .systemFont(ofSize: 25, weight: .bold)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var randomFilmText: UILabel = {
        var text = UILabel()
        text.text = "Get random film"
        text.font = .systemFont(ofSize: 25, weight: .bold)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    // MARK: text field for searching a film
    var searchField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.placeholder = "Enter search query"
        return field
    }()
    
    // MARK: buttons
    var searchButton: UIButton = {
        let grayButton = UIButton(type: .system)
        grayButton.translatesAutoresizingMaskIntoConstraints = false
        grayButton.setTitle("Search", for: .normal)
        grayButton.backgroundColor = UIColor.gray
        grayButton.setTitleColor(UIColor.white, for: .normal)
        grayButton.layer.cornerRadius = 8
        return grayButton
    }()
    
    var randomFilmButton: UIButton = {
        let grayButton = UIButton(type: .system)
        grayButton.translatesAutoresizingMaskIntoConstraints = false
        grayButton.setTitle("Tap Me", for: .normal)
        grayButton.backgroundColor = UIColor.gray
        grayButton.setTitleColor(UIColor.white, for: .normal)
        grayButton.layer.cornerRadius = 8
        return grayButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        networkManager.getTopMovies { result in
            switch result {
            case .success(let success):
                self.films.append(contentsOf: success.films ?? [])
            case .failure(let failure):
                print(failure)
            }
        }
        
        view.addSubview(searchText)
        
        view.addSubview(searchField)
        
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        view.addSubview(randomFilmText)
        
        view.addSubview(randomFilmButton)
        
        randomFilmButton.addTarget(self, action: #selector(randomFilmButtonTapped), for: .touchUpInside)
        
        setupLayout()
    }
    
    // MARK: action for search button
    @objc func searchButtonTapped() {
        // Get the search query from the search field
        guard let query = searchField.text else {
            return
        }
        
        // Perform the search operation with the query
        let found = performSearch(query: query)
        
        if !found {
            let alert = UIAlertController(title: "Alert", message: "Wrong title of the film or film is not found, please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: action for random film button
    @objc func randomFilmButtonTapped() {
        var index = Int.random(in: 0...99)
        
        let cellFilm = films[index]
        
        let openCell = DetailViewController()
        
        openCell.configure(movie: cellFilm)
        
        navigationController?.pushViewController(openCell, animated: true)
    }
    
    // MARK: search for a film
    func performSearch(query: String) -> Bool {
        
        
        for film in films {
            
            if film.nameRu?.lowercased() == query.lowercased() {
                
                let cellFilm = film
                
                let openCell = DetailViewController()
                
                openCell.configure(movie: cellFilm)
                
                navigationController?.pushViewController(openCell, animated: true)
                
                return true
            }
            
        }
        
        return false
        
        
    }
    
    // MARK: setting constraints
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            searchText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            searchField.topAnchor.constraint(equalTo: searchText.bottomAnchor, constant: 20),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10),
            searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            
            randomFilmText.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 100),
            randomFilmText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            randomFilmButton.topAnchor.constraint(equalTo: randomFilmText.bottomAnchor, constant: 20),
            randomFilmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomFilmButton.widthAnchor.constraint(equalToConstant: 100),
            randomFilmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    
    
    
    
}
