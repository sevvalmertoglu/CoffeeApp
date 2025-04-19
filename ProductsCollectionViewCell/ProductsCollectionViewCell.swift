//
//  ProductsCollectionViewCell.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit
import SDWebImage

extension ProductsCollectionViewCell {
    fileprivate enum Constants {
        enum UI {
            static let cornerRadius: CGFloat = 16
            static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
            static let priceFont: UIFont = .systemFont(ofSize: 15, weight: .semibold)
            static let titleColor: UIColor = UIColor.brown
            static let priceColor: UIColor = UIColor.darkGray
        }
    }
}

final class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var viewModel: ProductsCollectionViewCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.backgroundColor = UIColor.brown.withAlphaComponent(0.1)
        containerView.layer.cornerRadius = Constants.UI.cornerRadius
        containerView.layer.masksToBounds = true
        
        productImageView.layer.cornerRadius = Constants.UI.cornerRadius
        layer.masksToBounds = false

        titleLabel.font = Constants.UI.titleFont
        titleLabel.textColor = Constants.UI.titleColor

        priceLabel.font = Constants.UI.priceFont
        priceLabel.textColor = Constants.UI.priceColor

    }
}

extension ProductsCollectionViewCell: ProductsCollectionViewCellViewModelDelegate {

    func setProductTitle(_ text: String) {
        titleLabel.text = text
    }

    func setProductPrice(_ price: Double) {
        priceLabel.text = String(format: "%.2f TL", price)
    }

    func setProductImage(with url: URL?) {
        if let url = url {
            productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "cold-brew"))
        } else {
            productImageView.image = UIImage(named: "cold-brew")
        }
    }

}
