//
//  ForgotPasswordViewController.swift
//  FilmsApplication
//
//  Created by Kamil on 25.07.2023.
//

import Firebase

import UIKit


final class ForgotPasswordViewController: UIViewController {

    //MARK: Private properties
    private let recoveryLabel = UILabel()
    
    private let emailTextField = GeneralTextField(placeholder: TextsEnum.enterEmail.rawValue)
    
    private let resetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: Private methods
    
}

// MARK: Setting views

private extension ForgotPasswordViewController {
    
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        
        configureTextFields()
        configureResetButton()
        configureLabels()
    }
    
    @objc private func resetButtonClicked() {
        guard let email = emailTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            } else {
                self.showAlertWithWarning(TextsEnum.invalidData.rawValue)
            }
        }
    }
    
    private func showAlertWithWarning(_ warning: String) {
        let alert = UIAlertController(title: "Warning", message: warning, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

// MARK: Configurations

private extension ForgotPasswordViewController {
    func addSubViews() {
        view.addSubview(emailTextField)
        view.addSubview(resetButton)
        view.addSubview(recoveryLabel)
    }
    
    func configureTextFields() {
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        
        
        let stackView = UIStackView()
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 35.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.axis = .vertical
        emailTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -70).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
    }
    
    func configureLabels() {
        recoveryLabel.textColor = .black
        recoveryLabel.text = "Reset"
        recoveryLabel.textAlignment = .center
        recoveryLabel.font = .systemFont(ofSize: 30)
        recoveryLabel.translatesAutoresizingMaskIntoConstraints = false
        recoveryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        recoveryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    func configureResetButton() {
        resetButton.setTitle("Reset password", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: resetButton, topAnchorConstraint: 200)
        resetButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        resetButton.layer.cornerRadius = 10
        resetButton.layer.backgroundColor = UIColor.black.cgColor
        resetButton.addTarget(self, action:#selector(self.resetButtonClicked), for: .touchUpInside)
    }
}

// MARK: Constraints

private extension ForgotPasswordViewController {
    
    func setButtonConstraints(toItem: UIButton, topAnchorConstraint: CGFloat) {
        toItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraint),
            toItem.heightAnchor.constraint(equalToConstant: 50)
        ])
        toItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

