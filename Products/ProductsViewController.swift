//
//  ProductsViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    
    var viewModel: ProductsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteToggle), name: .didToggleFavorite, object: nil)
    }
    
    @objc private func handleFavoriteToggle() {
        viewModel.load()
    }
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ProductsCollectionViewCell.self, indexPath: indexPath)
        
        if let product = viewModel.product(indexPath.item) {
            cell.viewModel = ProductsCollectionViewCellViewModel(product: product, quantity: 1, isPlusMinusVisible: false)
        }
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedProduct = viewModel.product(indexPath.item) else { return }
        
        if let detailVC = storyboard?.instantiateViewController(identifier: "ProductsDetailViewController") as? ProductsDetailViewController {
            detailVC.viewModel = ProductDetailViewModel(product: selectedProduct)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.calculateCellSize(collectionViewWidth: Double(collectionView.bounds.width))
        return .init(width: size.width, height: size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: CGFloat(viewModel.cellPadding), bottom: .zero, right: CGFloat(viewModel.cellPadding))
    }
}

extension ProductsViewController: ProductsViewModelDelegate {
    func reloadData() {
          productsCollectionView.reloadData()
      }
    
    func prepareCollectionView() {
          productsCollectionView.dataSource = self
          productsCollectionView.delegate = self
          productsCollectionView.register(cellType: ProductsCollectionViewCell.self)
      }
}
