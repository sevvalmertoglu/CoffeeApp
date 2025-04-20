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

extension Notification.Name {
    static let didToggleFavorite = Notification.Name("didToggleFavorite")
}

protocol CartItemCellDelegate: AnyObject {
    func didTapPlusButton(on cell: ProductsCollectionViewCell)
    func didTapMinusButton(on cell: ProductsCollectionViewCell)
}

final class ProductsCollectionViewCell: UICollectionViewCell {
    weak var cartDelegate: CartItemCellDelegate?
    var product: Products?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var plusMinusStackView: UIStackView!
    @IBOutlet weak var quantityLabel: UILabel!
    
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
        productImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        productImageView.layer.masksToBounds = true
        
        layer.masksToBounds = false

        titleLabel.font = Constants.UI.titleFont
        titleLabel.textColor = Constants.UI.titleColor

        priceLabel.font = Constants.UI.priceFont
        priceLabel.textColor = Constants.UI.priceColor
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        viewModel.toggleFavorite()
        NotificationCenter.default.post(name: .didToggleFavorite, object: nil)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        viewModel.tappedPlusButton()
        cartDelegate?.didTapPlusButton(on: self)
       
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        viewModel.tappedMinusButton()
        cartDelegate?.didTapMinusButton(on: self)
    }
    
}

extension ProductsCollectionViewCell: ProductsCollectionViewCellViewModelDelegate {

    func setProductTitle(_ text: String) {
        titleLabel.text = text
    }

    func setProductPrice(_ price: Double) {
        priceLabel.text = String(format: "%.2f TL", price)
    }
    
    func setQuantity(_ quantity: Int) {
        quantityLabel.text = "\(quantity)"
    }
    
    func setProductImage(with imageSource: String?) {
        if let imageSource = imageSource {
            if imageSource.hasPrefix("http") {
                if let url = URL(string: imageSource) {
                    productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "cold-brew"))
                }
            } else {
                productImageView.image = UIImage(named: imageSource) ?? UIImage(named: "cold-brew")
            }
        } else {
            productImageView.image = UIImage(named: "cold-brew")
        }
    }
    
    func updateFavoriteStatus(isFavorite: Bool) {
        let heartImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        favoriteButton.setImage(heartImage, for: .normal)
    }
    
    func isPlusMinusVisible(isVisible: Bool) {
        plusMinusStackView.isHidden = !isVisible
    }
    
    func increaseQuantity() {
        if let currentQuantity = Int(quantityLabel.text ?? "1") {
            quantityLabel.text = "\(currentQuantity + 1)"
        }
    }
    
    func decreaseQuantity() {
        if let currentQuantity = Int(quantityLabel.text ?? "1") {
            quantityLabel.text = "\(currentQuantity - 1)"
        }
    }
}
