//
//  ProductContentView.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import SwiftUI

struct ProductContentView: View {
    var body: some View {
        productWrapperVC()
    }
}

#Preview {
    ProductContentView()
}

struct productWrapperVC: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProductsVC {
        let vc = ProductsVC()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ProductsVC, context: Context) {
    }
}
