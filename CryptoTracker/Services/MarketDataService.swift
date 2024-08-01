//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 31/07/2024.
//

import Foundation
import Combine
class MarketDataService {
    
    @Published var marketData:  MarketDataModel? = nil
    var marketCancellable: AnyCancellable?
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketCancellable = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] returnedData in
                self?.marketData = returnedData.data
                self?.marketCancellable?.cancel()
            })  
        
    }
}
