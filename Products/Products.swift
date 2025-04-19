//
//  Products.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

struct Products: Decodable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let image: String?
}

