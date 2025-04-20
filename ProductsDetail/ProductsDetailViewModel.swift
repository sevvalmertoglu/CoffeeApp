//
//  ProductsDetailViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var id: Int { get }
    var title: String { get }
    var price: String { get }
    var description: String { get }
    var imageUrl: String { get }
    var imageSource: ImageSource { get }
}

final class ProductDetailViewModel: ProductDetailViewModelProtocol {
    var id: Int {
        product.id ?? 1
    }
    
    private let product: Products
    
    init(product: Products) {
        self.product = product
    }
    
    var title: String {
        product.title ?? "Başlık Yok"
    }

    var price: String {
        if let priceValue = product.price {
            return "\(priceValue) ₺"
        } else {
            return "Fiyat Bilinmiyor"
        }
    }

    var description: String {
        product.description ?? "Açıklama Yok"
    }

    var imageUrl: String {
        product.image ?? ""
    }
    
    var imageSource: ImageSource {
        if let image = product.image {
            if image.hasPrefix("http") {
                return .url(image)
            } else {
                return .asset(image)
            }
        } else {
            return .asset("cold-brew")
        }
    }

}

enum ImageSource {
    case url(String)
    case asset(String)
}
