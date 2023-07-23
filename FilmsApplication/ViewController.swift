//
//  ViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 17.07.2023.
//

import UIKit




class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        b.backgroundColor = .red
        
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkManger.shared.getTopMovies()
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToTab), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    @objc func goToTab() {
        let tab = UITabBarController()
        

        let home = HomeViewController()
        home.title = "Home"
        let search = SearchViewController()
        search.title = "Search"
        let profile = ProfileViewController()
        profile.title = "Profile"
        
        tab.tabBar.tintColor = .label
        
        tab.setViewControllers([home, search, profile], animated: false)
        
        guard let items = tab.tabBar.items else { return }
        
        let images = ["house", "magnifyingglass.circle", "person.circle"]
        
        for i in 0...2 {
            items[i].image = UIImage(systemName: images[i])
        }
        
        tab.modalPresentationStyle = .fullScreen
        present(tab, animated: true)
    }
    
    
    
    
    
    

}


