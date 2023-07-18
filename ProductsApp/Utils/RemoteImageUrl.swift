//
//  RemoteImageUrl.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

class RemotelmageUrl: ObservableObject {
    
    @Published var data = Data()
    @Published var isLoading = false
    
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        isLoading = true
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data else {
                return
            }
            
            if let err {
                print(NetworkManagerErrorsHandler.requestError(.other(err)))
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.data = data
            }
        }.resume()
    }
}
