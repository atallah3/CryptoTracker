//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 24/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .foregroundStyle(Color.theme.accentColor)
            Text("Hello, world!")
                .foregroundStyle(Color.theme.green)
            Text("Hello, world!")
                .foregroundStyle(Color.theme.red)
            Text("Hello, world!")
                .foregroundStyle(Color.theme.background)
            Text("Hello, world!")
                .foregroundStyle(Color.theme.secondaryTextColor)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
