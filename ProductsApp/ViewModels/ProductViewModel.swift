//
//  ProductViewModel.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var products: [SingleProduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        if let url = URL(string: NetworkBuilder.ApiUrls.productsApiUrl.description) {
            let urlRequest = URLRequest(url: url)
            NetworkManager.shared.genericFutureCombineGetCall(url: urlRequest, type: Products.self)
                .sink {completion in
                    if case .failure(let error) = completion {
                        print(NetworkManagerErrorsHandler.requestError(.other(error)))
                    }
                } receiveValue: { [weak self] productsList in
                    guard let self else {
                        return
                    }
                    
                    self.products = productsList.products
                }
                .store(in: &cancellables)
        }
    }
}
