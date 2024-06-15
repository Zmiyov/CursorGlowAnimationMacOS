//
//  AppItem.swift
//  CursorGlowAnimationMacOS
//
//  Created by Volodymyr Pysarenko on 15.06.2024.
//

import Foundation

struct AppItem: Identifiable {
    var id = UUID().uuidString
    var image: String
}

var appItems = [
    AppItem(image: "itunes"),
    AppItem(image: "call"),
    AppItem(image: "settings")
]
