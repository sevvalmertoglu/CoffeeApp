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
