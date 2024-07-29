//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscribtion: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscribtion = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] returnedCoins in
                self?.allCoins.append(contentsOf: returnedCoins)
                self?.coinSubscribtion?.cancel()
            })
    }
}
