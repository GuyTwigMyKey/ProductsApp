//
//  ProductRow.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

struct ProductRow: View {
    
    var product: SingleProduct
    @ObservedObject var remoteImageUrl: RemotelmageUrl
    
    init(product: SingleProduct) {
        self.product = product
        remoteImageUrl = RemotelmageUrl(imageUrl: product.thumbnail)
    }
    
    var body: some View {
        VStack {
            if let image = UIImage(data: remoteImageUrl.data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .shadow(radius: 5, x: 5, y: 5)
                    .padding(.bottom, 10)
            }
            HStack {
                HStack {
                    Text(product.title)
                        .font(.system(size: 20))
                        .bold()
                }
            }
            HStack {
                ZStack {
                    Text("💰")
                        .font(.system(size: 100))
                        .opacity(0.2)
                    VStack {
                        Text("Product Price: ")
                        Text(String(product.price))
                    }
                }
                Spacer()
                ZStack {
                    Text("💯")
                        .font(.system(size: 100))
                        .opacity(0.2)
                    VStack {
                        Text("Product Rating: ")
                        Text(String(product.rating))
                    }
                }
            }
        }
        .cornerRadius(20)
        .padding(.all, 10)
        
    }
}

#Preview {
    ProductRow(product: SingleProduct(id: 0, title: "title", description: "description", price: 0, discountPercentage: 0.1, rating: 0.1, stock: 1, brand: "brand", category: "category", thumbnail: "thumbnail", images: ["string", "string"]))
}
