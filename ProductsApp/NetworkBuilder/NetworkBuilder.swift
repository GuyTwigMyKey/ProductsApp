//
//  NetworkBuilder.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import Foundation

class NetworkBuilder {
    
    enum ApiUrls: String {
        case productsApiUrl
        case usersApiUrl
        
        var description: String {
            switch self {
            case .productsApiUrl:
                return "https://dummyjson.com/products"
            case .usersApiUrl:
                return "https://dummyjson.com/users?limit=20&select=firstName,lastName,email,image"
            }
        }
    }
}

