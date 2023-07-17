//
//  ProductsModel.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import Foundation

struct Products: Codable {
    let products: [SingleProduct]
    
    init(products: [SingleProduct]) {
        self.products = products
    }
}

struct SingleProduct: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
    init(id: Int, title: String, description: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: [String]) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}
