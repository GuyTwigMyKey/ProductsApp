//
//  SlantedLine.swift
//  ProductsApp
//
//  Created by Guy Twig on 17/07/2023.
//

import SwiftUI

struct SlantedLine: View {
    let text: String
    
    var body: some View {
        ZStack {
            HStack {
                Rectangle()
                    .fill(.gray)
                    .frame(height: 4)
                    .rotationEffect(Angle(degrees: 25))
            }
            HStack {
                Text(text)
                    .frame(alignment: .center)
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

#Preview {
    SlantedLine(text: "guy")
}
