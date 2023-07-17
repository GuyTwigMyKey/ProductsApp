//
//  ProductDetails.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

struct ProductDetails: View {
    
    var product: SingleProduct
    @State private var isHearted = false
    @ObservedObject var remoteImageUrl: RemotelmageUrl
    
    init(product: SingleProduct) {
        self.product = product
        remoteImageUrl = RemotelmageUrl(imageUrl: product.thumbnail)
    }
    
    var body: some View {
        ScrollView {
            Text(product.title)
                .underline()
                .frame(alignment: .center)
                .font(.largeTitle.bold())
                .padding(.bottom, 20)
            if let image = UIImage(data: remoteImageUrl.data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 20)
            }
            fillTextForFields(title: "Product Rating: ", value: String(product.rating))
                .padding(.bottom, 10)
            fillTextForFields(title: "Product Description: ", value: product.description)
                .padding(.bottom, 10)
            fillTextForFields(title: "Price Before Discount: ", value: String(product.price))
                .padding(.bottom, 10)
            fillTextForFields(title: "Discount Percentage: ", value: String(product.discountPercentage) + "%")
                .padding(.bottom, 10)
            fillTextForFields(title: "Price After Discount: ", value:  calculatePriceAndRemoveDigitsAfterDots(price: product.price, discount: product.discountPercentage / 100))
                .padding(.bottom, 10)
            fillTextForFields(title: "Product Brand: ", value: String(product.brand))
                .padding(.bottom, 10)
            fillTextForFields(title: "Product Category: ", value: product.category)
                .padding(.bottom, 10)
            Spacer()
            Button {
                isHearted.toggle()
            } label: {
                if isHearted {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .tint(.red)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .tint(.black)
                }
                
            }
            .padding(.bottom, 50)
        }
    }
    
    func fillTextForFields(title: String, value: String) -> VStack<some View> {
        return VStack {
            Text(title)
                .font(.system(size: 30))
                .lineLimit(.max)
                .frame(alignment: .center)
            Text(String(value))
                .font(.system(size: 20))
                .lineLimit(.max)
                .frame(alignment: .center)
                .padding(.horizontal)
        }
    }
    
    func calculatePriceAndRemoveDigitsAfterDots(price: Int, discount: Double) -> String {
        let discountAmount = Double(Double(price) * discount)
        let finalPrice = Double(price) - discountAmount
        return String(format: "%.2f", finalPrice)
    }
}

#Preview {
    ProductDetails(product: SingleProduct(id: 0, title: "title", description: "description", price: 0, discountPercentage: 0.1, rating: 0.1, stock: 1, brand: "brand", category: "category", thumbnail: "thumbnail", images: ["string", "string"]))
}
