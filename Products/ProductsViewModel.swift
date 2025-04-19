//
//  ProductsViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

extension ProductsViewModel {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
        static let cellBannerImageViewAspectRatio: Double = 130/345
        static let cellDescriptionViewHeight: Double = 60
    }
}

protocol ProductsViewModelProtocol {
    var delegate: ProductsViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    
    func load()
    func product(_ index: Int) -> Products?
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
  
}

protocol ProductsViewModelDelegate: AnyObject {
    func reloadData()
    func prepareCollectionView()
}

final class ProductsViewModel {
    private var products: [Products] = []
    let networkManager: NetworkManager<ProductsEndpointItem>
    weak var delegate: ProductsViewModelDelegate?
    private let useMockData: Bool
    
    private var currentQuery: String
    
    init(networkManager: NetworkManager<ProductsEndpointItem>, query: String = "hot", useMockData: Bool = false) {
        self.networkManager = networkManager
        self.currentQuery = query
        self.useMockData = useMockData
    }
    
    private func fetchProducts() {
        if useMockData {
            loadMockProducts()
        } else {
            networkManager.request(endpoint: .productsPage(query: currentQuery), type: [Products].self) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.products = response
                    self?.delegate?.reloadData()
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    private func loadMockProducts() {
        self.products = [
            Products(id: 1, title: "Sandwich", price: 45.0, description: "Freshly made sandwich.", image: "sandvic"),
            Products(id: 2, title: "Croissant", price: 38.5, description: "Chocolate croissant.", image: "kruvasan"),
            Products(id: 3, title: "Cake Slice", price: 25.0, description: "Homemade cake slice.", image: "cake")
        ]
        self.delegate?.reloadData()
    }
}

extension ProductsViewModel: ProductsViewModelProtocol {
    var numberOfItems: Int {
        products.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func load() {
        delegate?.prepareCollectionView()
        fetchProducts()
    }
    
    func product(_ index: Int) -> Products? {
        products[index]
    }
    
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWidth = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        
        return (width: cellWidth, height: Constants.cellDescriptionViewHeight + bannerImageHeight)
    }
    
    func updateCategory(query: String) {
           self.currentQuery = query
           fetchProducts()
       }
}
