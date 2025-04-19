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
}

protocol ProductsCollectionViewCellViewModelDelegate: AnyObject {
    func setProductTitle(_ text: String)
    func setProductPrice(_ price: Double)
    func setProductImage(with imageSource: String?)
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
    }
}

