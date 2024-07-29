//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 24/07/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
                    .environmentObject(DeveloperProvider.shared.homeVM)
            }
        }
    }
}
