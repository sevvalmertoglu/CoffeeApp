//
//  CartViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 20.04.2025.
//

import Foundation
import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    var viewModel: CartViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            self.viewModel = CartViewModel()
            self.viewModel.delegate = self
        }
        viewModel.load()
    }

    
    func configure(with viewModel: CartViewModel) {
        self.viewModel = viewModel
        if isViewLoaded {
            viewModel.delegate = self
            viewModel.load()
        }
    }
}

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ProductsCollectionViewCell.self, indexPath: indexPath)

        if let product = viewModel.product(indexPath.item) {
            cell.viewModel = ProductsCollectionViewCellViewModel(product: product, isPlusMinusVisible: true)
        }
        return cell
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
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
        .init(top: .zero, left: CGFloat(viewModel.cellPadding), bottom: 20, right: CGFloat(viewModel.cellPadding))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CartSummaryFooterView.identifier,
                for: indexPath
            ) as! CartSummaryFooterView
            
            let summaryText = viewModel.createSummaryText()
            footer.configure(with: summaryText)
            
            return footer
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footer = CartSummaryFooterView()
        let summaryText = viewModel.createSummaryText()
        footer.configure(with: summaryText)
        
        let targetSize = CGSize(width: collectionView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let fittingSize = footer.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)

        return CGSize(width: collectionView.bounds.width, height: fittingSize.height)
    }
}

extension CartViewController: CartViewModelDelegate {
    func reloadData() {
        cartCollectionView.reloadData()
    }

    func prepareCollectionView() {
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        cartCollectionView.register(cellType: ProductsCollectionViewCell.self)
        cartCollectionView.register(
            CartSummaryFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: CartSummaryFooterView.identifier
        )
    }
}

