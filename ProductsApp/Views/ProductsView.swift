//
//  ProductsView.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var productsViewModels = ProductViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(productsViewModels.products) { product in
                    NavigationLink(destination: ProductDetails(product: product)) {
                        ProductRow(product: product)
                    }
                }
                .padding(.top, 30)
                Spacer()
                
            }
            .padding(.top, 0)
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProductsView()
}
