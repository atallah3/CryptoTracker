//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.allCoins.append(DeveloperProvider.shared.coin)
            self.portfolioCoins.append(DeveloperProvider.shared.coin)
        }
    }
}
