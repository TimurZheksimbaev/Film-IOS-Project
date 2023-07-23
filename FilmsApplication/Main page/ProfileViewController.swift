//
//  ProfileViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 19.07.2023.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    
    // MARK: profile picture
    let profilePic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    // MARK: email label
    let emailLabel: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 20, weight: .bold)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(profilePic)
        
        view.addSubview(emailLabel)
        emailLabel.text = getUserEmail()
        
        
        setupLayout()
    }
    
    // MARK: gettig user email from database
    func getUserEmail() -> String {
        var userEmail = ""
        let user = Auth.auth().currentUser
        if let user = user {
            
            let uid = user.uid
            userEmail = user.email ?? ""
        }
        
        return userEmail
    }

    
    // MARK: setting constraints 
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            profilePic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 300),
            profilePic.heightAnchor.constraint(equalToConstant: 300),
            
            emailLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 20),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}
