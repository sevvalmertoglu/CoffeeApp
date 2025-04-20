//
//  ProductsCollectionViewCellViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

protocol ProductsCollectionViewCellViewModelProtocol {
    var delegate: ProductsCollectionViewCellViewModelDelegate? { get set }
    var cartDelegate: CartItemCellDelegate? { get set }
    var isPlusMinusVisible: Bool { get }
    func load()
    func toggleFavorite()
    func tappedPlusButton()
    func tappedMinusButton()
}

protocol ProductsCollectionViewCellViewModelDelegate: AnyObject {
    func setProductTitle(_ text: String)
    func setProductPrice(_ price: Double)
    func setQuantity(_ quantity: Int)
    func setProductImage(with imageSource: String?)
    func updateFavoriteStatus(isFavorite: Bool)
    func isPlusMinusVisible(isVisible: Bool)
    func increaseQuantity()
    func decreaseQuantity()
}

final class ProductsCollectionViewCellViewModel {
    private let product: Products
    private var quantity: Int
    weak var delegate: ProductsCollectionViewCellViewModelDelegate?
    weak var cartDelegate: CartItemCellDelegate?

    let isPlusMinusVisible: Bool

    init(product: Products, quantity: Int, isPlusMinusVisible: Bool = false) {
        self.product = product
        self.quantity = quantity
        self.isPlusMinusVisible = isPlusMinusVisible
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
        
        delegate?.setQuantity(quantity)
        
        delegate?.setProductImage(with: product.image)
        
        let isFavorite = isProductFavorited()
        delegate?.updateFavoriteStatus(isFavorite: isFavorite)
        
        delegate?.isPlusMinusVisible(isVisible: isPlusMinusVisible)
    }
    
    func isProductFavorited() -> Bool {
        guard let favoriteProducts = UserDefaults.standard.array(forKey: "favList") as? [[String: Any]] else {
            return false
        }
        
        return favoriteProducts.contains { productDict in
            guard let id = productDict["id"] as? Int,
                  let title = productDict["title"] as? String,
                  let price = productDict["price"] as? Double,
                  let image = productDict["image"] as? String,
                  let description = productDict["description"] as? String else {
                return false
            }
            
            return id == product.id &&
            title == product.title &&
            price == product.price &&
            image == product.image &&
            description == product.description
        }
    }
    
    func toggleFavorite() {
        var favoriteProducts = UserDefaults.standard.array(forKey: "favList") as? [[String: Any]] ?? []
        
        if let index = favoriteProducts.firstIndex(where: { productDict in
            guard let id = productDict["id"] as? Int,
                  let title = productDict["title"] as? String,
                  let price = productDict["price"] as? Double,
                  let image = productDict["image"] as? String,
                  let description = productDict["description"] as? String else {
                return false
            }
            
            return id == product.id &&
            title == product.title &&
            price == product.price &&
            image == product.image &&
            description == product.description
        }) {
            favoriteProducts.remove(at: index)
        } else {
            let productDetails: [String: Any] = [
                "id": product.id ?? 0,
                "title": product.title ?? "",
                "price": product.price ?? 0.0,
                "image": product.image ?? "",
                "description": product.description ?? ""
            ]
            favoriteProducts.append(productDetails)
        }
        
        UserDefaults.standard.set(favoriteProducts, forKey: "favList")
        
        delegate?.updateFavoriteStatus(isFavorite: isProductFavorited())
    }
    
    func tappedPlusButton() {
        delegate?.increaseQuantity()
    }
    
    func tappedMinusButton() {
        delegate?.decreaseQuantity()
    }
}

