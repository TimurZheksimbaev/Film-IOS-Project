import Firebase

import UIKit


final class LoginViewController: UIViewController {

    //MARK: Private properties
    private let emailTextField = GeneralTextField(placeholder: TextsEnum.enterEmail.rawValue)
    private let passwordTextField = GeneralTextField(placeholder: TextsEnum.enterPassword.rawValue)
    
    private let signInButton = UIButton()
    
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    
    private let eyeButtonForPassword = EyeButton()
    private var isEyeButtonForPasswordPrivate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func goToMainPage() {
        
        let tab = UITabBarController()

        let home = UINavigationController(rootViewController: HomeViewController())
        home.title = "Home"
        let search = UINavigationController(rootViewController: SearchViewController())
        search.title = "Search"
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.title = "Profile"



        tab.tabBar.tintColor = .black

        tab.setViewControllers([home, search, profile], animated: false)

        guard let items = tab.tabBar.items else { return }

        let images = ["house", "magnifyingglass.circle", "person.circle"]

        for i in 0...2 {
            items[i].image = UIImage(systemName: images[i])
        }

        tab.modalPresentationStyle = .fullScreen
        
        navigationController?.present(tab, animated: true)
    }
    
    //MARK: Private methods

    @objc private func signInButtonClicked() {
        guard let password = passwordTextField.text, !password.isEmpty, let email = emailTextField.text, !email.isEmpty else {
            showAlertWithWarning(TextsEnum.fillFields.rawValue)
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                self.goToMainPage()
            } else if password.count < 6 {
                self.showAlertWithWarning("Password length should be 6 or more")
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
    
    @objc private func eyeButtonForPasswordPressed() {
        let imageName = isEyeButtonForPasswordPrivate ? "eye" : "eye.slash"
        
        passwordTextField.isSecureTextEntry.toggle()
        eyeButtonForPassword.setImage(UIImage(systemName: imageName), for: .normal)
        isEyeButtonForPasswordPrivate.toggle()
    }

}

// MARK: Setting views

private extension LoginViewController {
    
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        addActions()
        
        configureTextFields()
        configureLabels()
        configureSignInButton()
    }
    
    
}

// MARK: Configurations

private extension LoginViewController {
    func addSubViews() {
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(signInButton)
    }
    
    func addActions() {
        eyeButtonForPassword.addTarget(self, action: #selector(self.eyeButtonForPasswordPressed), for: .touchUpInside)
    }
    
    func configureLabels() {
        emailLabel.textColor = .black
        emailLabel.text = TextsEnum.email.rawValue
        emailLabel.font = .systemFont(ofSize: 22)
        
        passwordLabel.textColor = .black
        passwordLabel.text = TextsEnum.email.rawValue
        passwordLabel.font = .systemFont(ofSize: 22)
        
        setLabelConstraints(toItem: emailLabel, topAnchorConstraint: 50)
        setLabelConstraints(toItem: passwordLabel, topAnchorConstraint: 190)
    }
    
    func configureTextFields() {
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        setTextFieldConstraints(toItem: emailTextField, topAnchorConstraint: 100)
        
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = eyeButtonForPassword
        passwordTextField.rightViewMode = .always
        setTextFieldConstraints(toItem: passwordTextField, topAnchorConstraint: 240)

    }
    
    
    func configureSignInButton() {
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints(toItem: signInButton, topAnchorConstraint: 350)
        signInButton.layer.cornerRadius = 10
        signInButton.layer.backgroundColor = UIColor.black.cgColor
        signInButton.addTarget(self, action:#selector(self.signInButtonClicked), for: .touchUpInside)
    }
}

// MARK: Constraints

private extension LoginViewController {
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
