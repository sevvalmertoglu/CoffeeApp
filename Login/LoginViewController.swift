//
//  LoginViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private var containerStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .vertical
        containerStackView.spacing = 16
        return containerStackView
    }()
    
    private var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Mail"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.brown.cgColor
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Şifre"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.brown.cgColor
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor.brown
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.layer.cornerRadius = 20
        return loginButton
    }()

    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 245/255, green: 235/255, blue: 224/255, alpha: 1)

        containerStackView.addArrangedSubview(userNameTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(loginButton)
        
        view.addSubview(containerStackView)
        addGestureToView()
        
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc private func loginButtonTapped() {
        guard let email = userNameTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Lütfen tüm alanları doldurun.")
            return
        }
        viewModel.login(email: email, password: password)
    }

    private func addGestureToView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: LoginViewModelDelegate {

    func showLoadingView() {
        print("Yükleniyor...")
    }

    func hideLoadingView() {
        print("Yükleme tamamlandı.")
    }

    func loginSuccess() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let tabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController") as? UITabBarController else { return }
            self.view.window?.rootViewController = tabBarController
        }
    }

    func loginFailed(error: String) {
        showAlert(message: error)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


