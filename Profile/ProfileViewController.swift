//
//  ProfileViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    private let viewModel = ProfileViewModel()

    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mail:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Çıkış Yap"
        config.baseBackgroundColor = .systemBrown
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.93, blue: 0.88, alpha: 1.0)
        setupViews()
        bindData()
    }

    private func setupViews() {
        view.addSubview(emailTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            emailTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            emailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.widthAnchor.constraint(equalToConstant: 150)
        ])

        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    private func bindData() {
        emailLabel.text = viewModel.userEmail
    }

    @objc private func logoutButtonTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
                loginVC.viewModel = LoginViewModel()
                viewModel.logout()
                sceneDelegate.window?.rootViewController = loginVC
            }
        }
    }
}


