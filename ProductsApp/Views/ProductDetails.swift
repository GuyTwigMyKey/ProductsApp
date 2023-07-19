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
    @State private var isBouncing = false
    @ObservedObject var remoteImageUrl: RemotelmageUrl
    
    init(product: SingleProduct) {
        self.product = product
        remoteImageUrl = RemotelmageUrl(imageUrl: product.thumbnail)
    }
    
    var body: some View {
        ScrollView {
            Text(product.title)
                .font(.system(size: 55))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .shadow(color: .gray, radius: 0.1, x: 2 ,y: 2)
                .padding(.bottom, 5)
            if remoteImageUrl.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                if let image = UIImage(data: remoteImageUrl.data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(isBouncing ? 1.4 : 1.0)
                        .offset(x: isBouncing ? -30 : 0, y: isBouncing ? -30 : 0)
                }
            }
            VStack {
                HStack {
                    Text("Product Description: ")
                        .font(.system(size: 25))
                    +
                    Text(String(product.description))
                        .font(.system(size: 15))
                }
                .lineLimit(nil)
                .padding(.horizontal)
                .padding(.bottom, 0)
                HStack {
                    Spacer()
                    fillTextForFields(title: "Brand: ", titleSize: 20, value: String(product.brand), valuseSize: 15)
                    Spacer()
                    fillTextForFields(title: "Category: ", titleSize: 20, value: product.category, valuseSize: 15)
                    Spacer()
                    fillTextForFields(title: "Rating: ", titleSize: 20, value: String(product.rating), valuseSize: 15)
                        .overlay(
                            GeometryReader { geo in
                                Text("💯")
                                    .font(.system(size: 50))
                                    .opacity(0.2)
                                    .multilineTextAlignment(.center)
                                    .clipped()
                                    .frame(height: geo.size.height)
                            })
                    
                    Spacer()
                    Button {
                        if !isHearted {
                            withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0)) {
                                isBouncing = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    isBouncing = false
                                }
                            }
                        }
                        isHearted.toggle()
                    } label: {
                        if isHearted {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFill()
                                .tint(.purple)
                                .scaleEffect(isBouncing ? 1.2 : 1.0)
                                .offset(y: isBouncing ? -20 : 0)
                                .rotationEffect(isBouncing ? .degrees(360) : .degrees(720))
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFill()
                                .tint(.black)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, -20)
                HStack {
                    Spacer()
                    fillTextForFields(title: String(product.discountPercentage) + "%", titleSize: 25, titleColor: .red, value: "Off", valuseSize: 20, valueColor: .red)
                    Spacer()
                    SlantedLine(text: String(product.price))
                        .frame(width: 100, height: 100)
                    Spacer()
                    fillTextForFields(title: "Sale Price: ", titleSize: 20, titleColor: .red, value: calculatePriceAndRemoveDigitsAfterDots(price: product.price, discount: product.discountPercentage / 100), valuseSize: 25, valueColor: .red)
                    Spacer()
                }
                .padding()
                .overlay(
                    GeometryReader { geo in
                        Image("sale")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: geo.size.height)
                            .clipped()
                            .opacity(0.1)
                    })
                .padding(.bottom, 20)
            }
            .padding(.top, 0)
            .padding(.bottom, 0)
            
        }
    }
    
    func fillTextForFields(title: String, titleSize: CGFloat, titleAlignmen: TextAlignment = .center, titleColor: Color = .black, value: String, valuseSize: CGFloat, valueColor: Color = .black) -> VStack<some View> {
        return VStack {
            Text(title)
                .font(.system(size: titleSize))
                .lineLimit(.max)
                .multilineTextAlignment(titleAlignmen)
                .foregroundColor(titleColor)
            Text(String(value))
                .font(.system(size: valuseSize))
                .lineLimit(.max)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(valueColor)
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
