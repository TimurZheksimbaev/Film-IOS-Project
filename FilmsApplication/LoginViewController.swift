import Firebase

import UIKit

final class LoginViewController: UIViewController {

    let emailTextField = GeneralTextField(placeholder: "Enter your email address")
    let passwordTextField = GeneralTextField(placeholder: "Enter your password")
    
    let signInButton = UIButton()
    
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    
    let eyeButtonForPassword = EyeButton()
    
    var isEyeButtonForPasswordPrivate = true



    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .emailAddress
        
        setupView()
        
        configureLabels()
        configureTextFields()
        
        configureSignInButton()
    }
    
    func configureLabels() {
        self.view.addSubview(emailLabel)
        emailLabel.textColor = .black
        emailLabel.text = "Email"
        emailLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: emailLabel, topAnchorConstraint: 50)
        
        self.view.addSubview(passwordLabel)
        passwordLabel.textColor = .black
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 22)
        setLabelConstraints(toItem: passwordLabel, topAnchorConstraint: 190)
    }
    
    func configureTextFields() {
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .emailAddress
    }
    
    func configureSignInButton() {
        self.view.addSubview(signInButton)
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signInButton, topAnchorConstraint: 350)
        signInButton.layer.cornerRadius = 10
        signInButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        signInButton.addTarget(self, action:#selector(self.signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func signInButtonClicked() {
        if passwordTextField.text != "" && emailTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error == nil {
                    self.showAlertWithWarning("Success!")

                } else if self.passwordTextField.text!.count < 6 {
                    self.showAlertWithWarning("Password length should be 6 or more")
                } else {
                    self.showAlertWithWarning("Incorrect email or/and password")
                }
            }
        } else {
            showAlertWithWarning("Please fill all the fields")
        }
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
extension LoginViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        addActions()
        
        setupPassword()
        
        setupLayout()
    }
}

// MARK: Setting
extension LoginViewController {
    func addSubViews() {
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
extension LoginViewController {
    func setupLayout() {
        
        setTextFieldConstraints(toItem: emailTextField, topAnchorConstraint: 100)
        setTextFieldConstraints(toItem: passwordTextField, topAnchorConstraint: 240)
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
