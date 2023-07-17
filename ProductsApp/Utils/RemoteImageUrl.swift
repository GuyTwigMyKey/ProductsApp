//
//  RemoteImageUrl.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

class RemotelmageUrl: ObservableObject {
    
    @Published var data = Data()
    
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data else {
                return
            }
            
            if let err {
                print(NetworkManagerErrorsHandler.requestError(.other(err)))
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
