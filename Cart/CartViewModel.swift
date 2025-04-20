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
    func product(_ index: Int) -> Products?
    func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
}

protocol CartViewModelDelegate: AnyObject {
    func reloadData()
    func prepareCollectionView()
}

final class CartViewModel {
    private var cartProducts: [Products] = []
    weak var delegate: CartViewModelDelegate?

    func product(_ index: Int) -> Products? {
        guard index < cartProducts.count else { return nil }
        return cartProducts[index]
    }

    func load() {
        self.cartProducts = CartManager.fetchCart()
        delegate?.prepareCollectionView()
        delegate?.reloadData()
    }

}

extension CartViewModel: CartViewModelProtocol {
    func createSummaryText() -> String {
        var summary = ""
        var total: Double = 0
        let grouped = Dictionary(grouping: cartProducts, by: { $0.title })
        
        for (title, products) in grouped {
            let count = products.count
            let price = (products.first?.price ?? 0.0) * Double(count)
            summary += "\(count) tane \(title ?? "") - \(price) TL\n"
            total += price
        }
        
        summary += "\nToplam Tutar: \(total) TL"
        return summary
    }
    
    var numberOfItems: Int {
         return cartProducts.count
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
