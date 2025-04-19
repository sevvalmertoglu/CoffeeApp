//
//  ProductsCollectionViewCellViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

protocol ProductsCollectionViewCellViewModelProtocol {
    var delegate: ProductsCollectionViewCellViewModelDelegate? { get set }
    func load()
    func toggleFavorite()
}

protocol ProductsCollectionViewCellViewModelDelegate: AnyObject {
    func setProductTitle(_ text: String)
    func setProductPrice(_ price: Double)
    func setProductImage(with imageSource: String?)
    func updateFavoriteStatus(isFavorite: Bool)
}

final class ProductsCollectionViewCellViewModel {
    private let product: Products
    weak var delegate: ProductsCollectionViewCellViewModelDelegate?

    init(product: Products) {
        self.product = product
    }
}

extension ProductsCollectionViewCellViewModel: ProductsCollectionViewCellViewModelProtocol {
    func load() {
        if let title = product.title {
            delegate?.setProductTitle(title)
        }
        
        if let price = product.price {
            delegate?.setProductPrice(price)
        }
        
        delegate?.setProductImage(with: product.image)
        
        let isFavorite = isProductFavorited()
        delegate?.updateFavoriteStatus(isFavorite: isFavorite)
    }
    
    func isProductFavorited() -> Bool {
            guard let favoriteProducts = UserDefaults.standard.array(forKey: "favList") as? [Int] else {
                return false
            }
        return favoriteProducts.contains(product.id ?? 1)
        }

        func toggleFavorite() {
            var favoriteProducts = UserDefaults.standard.array(forKey: "favList") as? [Int] ?? []
            
            if let index = favoriteProducts.firstIndex(of: product.id ?? 1) {
                favoriteProducts.remove(at: index)
            } else {
                favoriteProducts.append(product.id ?? 1)
            }
            
            UserDefaults.standard.set(favoriteProducts, forKey: "favList")
            
            delegate?.updateFavoriteStatus(isFavorite: isProductFavorited())
        }
}

