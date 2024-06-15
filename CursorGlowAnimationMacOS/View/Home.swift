//
//  Home.swift
//  CursorGlowAnimationMacOS
//
//  Created by Volodymyr Pysarenko on 15.06.2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 728)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), content: {
                
                ForEach(1...4, id: \.self) { _ in
                    CursorGlowView(glowOpacity: 0.5, blurRadius: 45) {
                        Rectangle()
                            .fill(.card)
                    }
                    .frame(height: 180)
                }
            })
            .padding()
            .padding(.top, 30)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(width: 350, height: 728)
    }
}

#Preview {
    Home()
}
