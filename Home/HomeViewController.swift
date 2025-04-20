//
//  HomeViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let bannerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.brown
        pageControl.pageIndicatorTintColor = UIColor.brown.withAlphaComponent(0.3)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let buttonGridContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 236/255, blue: 230/255, alpha: 1.0)
        setupBannerSlider()
        setupCategoryButtons()
    }
    
    private func setupBannerSlider() {
        view.addSubview(bannerScrollView)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            bannerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bannerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerScrollView.heightAnchor.constraint(equalToConstant: 250),
            
            pageControl.topAnchor.constraint(equalTo: bannerScrollView.bottomAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let bannerImages = ["banner1", "banner2", "banner3"]
        
        for i in 0..<bannerImages.count {
            let imageView = UIImageView()
            imageView.image = UIImage(named: bannerImages[i])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(
                x: CGFloat(i) * view.frame.width,
                y: 0,
                width: view.frame.width,
                height: 250
            )
            bannerScrollView.addSubview(imageView)
        }
        
        bannerScrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(bannerImages.count),
            height: 250
        )
        bannerScrollView.delegate = self
    }
    
    private func setupCategoryButtons() {
        view.addSubview(buttonGridContainer)
        
        NSLayoutConstraint.activate([
            buttonGridContainer.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            buttonGridContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonGridContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let categories = [
            ("Sıcak İçecekler", "cup.and.saucer.fill"),
            ("Soğuk İçecekler", "drop.fill"),
            ("Yiyecekler", "fork.knife"),
            ("Favoriler", "heart.fill")
        ]
        
        for row in 0..<2 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 16
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            
            for col in 0..<2 {
                let index = row * 2 + col
                if index < categories.count {
                    let (title, systemImage) = categories[index]
                    let button = UIButton(type: .system)
                    
                    var config = UIButton.Configuration.filled()
                    config.title = title
                    config.image = UIImage(systemName: systemImage)
                    config.imagePlacement = .leading
                    config.imagePadding = 10
                    config.baseBackgroundColor = UIColor.brown
                    config.baseForegroundColor = .white
                    config.cornerStyle = .medium
                    
                    var titleAttr = AttributedString(title)
                    titleAttr.font = UIFont.boldSystemFont(ofSize: 18)
                    config.attributedTitle = titleAttr
                    
                    let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
                    config.image = UIImage(systemName: systemImage, withConfiguration: largeConfig)
                    
                    button.configuration = config
                    
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    
                    button.accessibilityLabel = title
                    button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
                    
                    rowStack.addArrangedSubview(button)
                }
            }
            buttonGridContainer.addArrangedSubview(rowStack)
        }
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let label = sender.accessibilityLabel else { return }
        let selectedQuery: String
        var useMock = false

        switch label {
        case "Sıcak İçecekler":
            selectedQuery = "hot"
        case "Soğuk İçecekler":
            selectedQuery = "iced"
        case "Yiyecekler":
            useMock = true
            selectedQuery = "food"
        case "Favoriler":
            selectedQuery = "favorites"
        default:
            selectedQuery = "hot"
        }
        
        if let destinationVC = storyboard?.instantiateViewController(identifier: "ProductsViewController") as? ProductsViewController {
            destinationVC.viewModel = ProductsViewModel(networkManager: NetworkManager<ProductsEndpointItem>(), query: selectedQuery, useMockData: useMock)
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}


