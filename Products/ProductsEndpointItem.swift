//
//  ProductsEndpointItem.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

enum ProductsEndpointItem: Endpoint {
    case productsPage(query: String)
    var baseUrl: String { "https://api.sampleapis.com/coffee/"}
    var path: String {
        switch self {
        case .productsPage(let query): return "\(query)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .productsPage: return .get
        }
    }
}
