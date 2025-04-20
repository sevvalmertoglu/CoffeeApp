//
//  CartViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 20.04.2025.
//

import Foundation

extension CartViewModel {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
        static let cellBannerImageViewAspectRatio: Double = 130/345
        static let cellDescriptionViewHeight: Double = 60
    }
}

protocol CartViewModelProtocol {
    var delegate: CartViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    
    func load()
    func createSummaryText() -> String
    func cartItem(_ index: Int) -> CartItem?
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
    func increaseQuantity(at index: Int)
    func decreaseQuantity(at index: Int)
}

protocol CartViewModelDelegate: AnyObject {
    func reloadData()
    func prepareCollectionView()
}

final class CartViewModel {
    private(set) var cartItems: [CartItem] = []
    weak var delegate: CartViewModelDelegate?
    
    func product(_ index: Int) -> Products? {
        guard index < cartItems.count else { return nil }
        return cartItems[index].product
    }
    
    func load() {
        cartItems = CartManager.fetchCart()
        delegate?.prepareCollectionView()
        delegate?.reloadData()
    }
    
    func increaseQuantity(at index: Int) {
        guard index < cartItems.count else { return }
        cartItems[index].quantity += 1
        CartManager.updateCartItems(cartItems)
        load()
    }
    
    func decreaseQuantity(at index: Int) {
        guard index < cartItems.count else { return }
        cartItems[index].quantity -= 1
        if cartItems[index].quantity == 0 {
            cartItems.remove(at: index)
        }
        CartManager.updateCartItems(cartItems)
        load()
    }
}

extension CartViewModel: CartViewModelProtocol {
    func cartItem(_ index: Int) -> CartItem? {
        guard index < cartItems.count else { return nil }
        return cartItems[index]
    }
    
    func createSummaryText() -> String {
        var summaryLines: [String] = []
        for item in cartItems {
            let name = item.product.title ?? "Ürün"
            let quantity = item.quantity
            let unitPrice = item.product.price ?? 0.0
            let totalItemPrice = unitPrice * Double(quantity)
            
            let line = "\(quantity) tane \(name) - \(String(format: "%.2f", totalItemPrice)) TL"
            summaryLines.append(line)
        }
        
        let totalPrice = cartItems.reduce(0.0) { $0 + ($1.product.price ?? 0) * Double($1.quantity) }
        summaryLines.append("Toplam: \(String(format: "%.2f", totalPrice)) TL")
        return summaryLines.joined(separator: "\n")
    }
    
    var numberOfItems: Int {
        cartItems.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWidth = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        return (width: cellWidth, height: Constants.cellDescriptionViewHeight + bannerImageHeight)
    }
}
