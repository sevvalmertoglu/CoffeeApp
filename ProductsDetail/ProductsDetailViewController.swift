//
//  ProductsDetailViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit
import SDWebImage

final class ProductsDetailViewController: UIViewController {
    
    var viewModel: ProductDetailViewModelProtocol!
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.brown
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.systemBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Satın Al", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.brown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 236/255, blue: 230/255, alpha: 1.0)
        setupLayout()
        configureView()
    }
    
    private func setupLayout() {
        view.addSubview(productImageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buyButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureView() {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        descriptionLabel.text = viewModel.description
        
        switch viewModel.imageSource {
        case .url(let urlString):
            if let url = URL(string: urlString) {
                productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "cold-brew"))
            } else {
                productImageView.image = UIImage(named: "cold-brew")
            }
        case .asset(let assetName):
            productImageView.image = UIImage(named: assetName) ?? UIImage(named: "cold-brew")
        }
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    @objc private func buyButtonTapped() {
        let selectedProduct = Products(
            id: viewModel.id,
            title: viewModel.title,
            price: Double(viewModel.price.replacingOccurrences(of: " ₺", with: "")),
            description: viewModel.description,
            image: viewModel.imageUrl
        )
        
        CartManager.saveToCart(product: selectedProduct)
        
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
}

