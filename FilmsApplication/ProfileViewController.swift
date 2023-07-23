//
//  ProfileViewController.swift
//  FilmsProject
//
//  Created by Тимур Жексимбаев on 19.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let login: UITextView = {
        let text = UITextView()
        text.text = "a;lsdfj;alsdkjf;alkdfj;lasdj"
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(login)
        setupLayout()
    }


    func setupLayout() {
        NSLayoutConstraint.activate([
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            login.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            
        ])
    }
}
