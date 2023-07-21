//
//  ViewController.swift
//  FilmsApplication
//
//  Created by Kamil on 18.07.2023.
//

import UIKit
import Firebase

final class RegisterViewController: UIViewController {
    
    let usernameTextField = GeneralTextField(placeholder: "Enter your username")
    let emailTextField = GeneralTextField(placeholder: "Enter your email address")
    let passwordTextField = GeneralTextField(placeholder: "Enter your password")
    
    let signUpButton = UIButton()
    let signInButton = UIButton()
    
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let askLabel = UILabel()
    
    let eyeButtonForPassword = EyeButton()
    
    var isEyeButtonForPasswordPrivate = true



    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        setupView()
        
        configureLabels()
        
        configureSignUpButton()
        configureSignInButton()
    }
    
    func configureLabels() {
        self.view.addSubview(usernameLabel)
        usernameLabel.textColor = .black
        usernameLabel.text = "Username"
        usernameLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: usernameLabel, topAnchorConstraint: 50)
        
        self.view.addSubview(emailLabel)
        emailLabel.textColor = .black
        emailLabel.text = "Email"
        emailLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: emailLabel, topAnchorConstraint: 190)
        
        self.view.addSubview(passwordLabel)
        passwordLabel.textColor = .black
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: passwordLabel, topAnchorConstraint: 330)
        
        self.view.addSubview(askLabel)
        askLabel.textColor = .black
        askLabel.text = "Already have an account?"
        askLabel.textAlignment = .center
        askLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: askLabel, topAnchorConstraint: 540)
    }
    
    func configureTextFields() {
        usernameTextField.autocapitalizationType = .none
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .emailAddress
    }
    
    func configureSignUpButton() {
        self.view.addSubview(signUpButton)
        
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signUpButton, topAnchorConstraint: 465)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        signUpButton.addTarget(self, action:#selector(self.signUpButtonClicked), for: .touchUpInside)
        
    }
    
    func configureSignInButton() {
        self.view.addSubview(signInButton)
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signInButton, topAnchorConstraint: 600)
        signInButton.layer.cornerRadius = 10
        signInButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        signInButton.addTarget(self, action:#selector(self.signInButtonClicked), for: .touchUpInside)
    }
    
    
    
    @objc func signUpButtonClicked() {
        if passwordTextField.text != "" && emailTextField.text != "" && usernameTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error == nil {
                    let ref = Database.database(url: "https://filmsapplication-6d462-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users")
                    ref.child(result!.user.uid).updateChildValues(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
                    self.present(LoginViewController(), animated: true, completion: nil)
                } else {
                    self.showAlertWithWarning("Invalid data")
                }
            }
        } else {
            showAlertWithWarning("Please fill all the fields")
        }
    }
    
    @objc func signInButtonClicked() {
        self.present(LoginViewController(), animated: true, completion: nil)
    }
    
    func showAlertWithWarning(_ warning: String) {
        let alert = UIAlertController(title: "Warning", message: warning, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func eyeButtonForPasswordPressed() {
        let imageName = isEyeButtonForPasswordPrivate ? "eye" : "eye.slash"
        
        passwordTextField.isSecureTextEntry.toggle()
        eyeButtonForPassword.setImage(UIImage(systemName: imageName), for: .normal)
        isEyeButtonForPasswordPrivate.toggle()
    }


}

// MARK: Setting views
extension RegisterViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        addActions()
        
        setupPassword()
        
        setupLayout()
    }
}

// MARK: Setting
extension RegisterViewController {
    func addSubViews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
    }
    
    func addActions() {
        eyeButtonForPassword.addTarget(self, action: #selector(self.eyeButtonForPasswordPressed), for: .touchUpInside)
    }
    
    func setupPassword() {
        passwordTextField.rightView = eyeButtonForPassword
        passwordTextField.rightViewMode = .always
    }
}

// MARK: Layouts (constraints)
extension RegisterViewController {
    func setupLayout() {
        
        setTextFieldConstraints(toItem: usernameTextField, topAnchorConstraint: 100)
        setTextFieldConstraints(toItem: emailTextField, topAnchorConstraint: 240)
        setTextFieldConstraints(toItem: passwordTextField, topAnchorConstraint: 380)
    }
    
    func setTextFieldConstraints(toItem: UITextField, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            toItem.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70)
        ])
    }
    
    func setLabelConstraints(toItem: UILabel, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            toItem.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70),
            toItem.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07)
        ])
    }
    
    func setButtonConstraints(toItem: UIButton, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.widthAnchor.constraint(equalToConstant: 100),
            toItem.heightAnchor.constraint(equalToConstant: 50)
        ])
        toItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
