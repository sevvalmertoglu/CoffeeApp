//
//  ProductsViewController.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var viewModel: ProductsViewModelProtocol! { // Bu class'ta viewModel'ı kullanabilmeyi sağlar
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
 

}

extension ProductsViewController: ProductsViewModelDelegate {
    
}
