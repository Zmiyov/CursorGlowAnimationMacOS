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
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), content: {
                
                ForEach(appItems) { appItem in
                    CursorGlowView(glowOpacity: 0.5, blurRadius: 35) {
                        Image(appItem.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 70, height: 70)
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
