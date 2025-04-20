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

        if let index = cart.firstIndex(where: { $0.product.title == product.title }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }

        if let encoded = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }

    static func fetchCart() -> [CartItem] {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let decoded = try? JSONDecoder().decode([CartItem].self, from: data) {
            return decoded
        }
        return []
    }
    
    static func updateCartItems(_ items: [CartItem]) {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
}

