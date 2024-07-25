//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 24/07/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
