//
//  NetworkManagerErrorsHandler.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import Foundation

enum NetworkManagerErrorsHandler: Error {
    
    case requestError(RequestError)
    case serverError(ServerError)
    
    enum RequestError {
        case invalidRequest(URLRequest)
        case decodingError(String)
        case encodingError(EncodingError)
        case other(Error)
    }

    enum ServerError {
        case decodingError(DecodingError)
        case noInternetConnection
        case timeout
        case internalServerError
        case invalidStatusCode(String)
        case other(statusCode: Int, response: HTTPURLResponse)
    }
}
