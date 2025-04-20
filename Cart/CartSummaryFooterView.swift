//
//  CartSummaryFooterView.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 20.04.2025.
//

import UIKit

final class CartSummaryFooterView: UICollectionReusableView {
    
    static let identifier = "CartSummaryFooterView"
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hex: "#493628")
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(hex: "#493628")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hex: "#D6C0B3")
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubview(summaryLabel)
        addSubview(totalLabel)
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            totalLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8),
            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with summaryText: String) {
        let lines = summaryText.components(separatedBy: "\n")
        let lastLine = lines.last ?? ""
        let mainText = lines.dropLast().joined(separator: "\n")
        
        summaryLabel.text = mainText
        totalLabel.text = lastLine
    }
}



