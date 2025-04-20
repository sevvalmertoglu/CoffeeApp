//
//  CartManager.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 20.04.2025.
//

import Foundation

final class CartManager {
    
    private static let cartKey = "CartList"
    
    static func saveToCart(product: Products) {
        var cart = fetchCart()
        cart.append(product)
        
        if let encoded = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
    
    static func fetchCart() -> [Products] {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let decoded = try? JSONDecoder().decode([Products].self, from: data) {
            return decoded
        }
        return []
    }
}
