//
//  ProductsViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

protocol ProductsViewModelProtocol { //Haberleşmeleri için Protocol oluşturduk
    var delegate: ProductsViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    
    func load()
    //func restaurant(_ index: Int) -> Restaurant?
    //func calculateCellSize(collectionViewWidth: Double) -> (width: Double, height: Double)
  
}


protocol ProductsViewModelDelegate: AnyObject {
    //func reloadData()
    //func prepareCollectionView()
}

final class ProductsViewModel {
    private var products: [Products] = []
    let networkManager: NetworkManager<ProductsEndpointItem>
    weak var delegate: ProductsViewModelDelegate?

    
    init(networkManager: NetworkManager<ProductsEndpointItem>) {
        self.networkManager = networkManager
    }
    
    private func fetchProducts(query: String) {
        networkManager.request(endpoint: .productsPage(query: query), type: [Products].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.products.append(contentsOf: response)
                //self?.delegate?.reloadData() çok önemli yaz bunu
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
  
  
}

extension ProductsViewModel: ProductsViewModelProtocol {
    var numberOfItems: Int {
        5
    }
    
    var cellPadding: Double {
        5.0
    }
    
    func load() {
        //delegate?.prepareCollectionView() önemli yaz bunu
        fetchProducts(query: "hot")
    }
}
