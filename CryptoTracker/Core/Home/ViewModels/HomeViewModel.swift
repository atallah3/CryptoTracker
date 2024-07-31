//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var marketData: MarketDataModel?
    
    let coinDataService = CoinDataService()
    let marketDataService = MarketDataService()
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map( filterCoins )
            .sink { [weak self] returnedData in
                self?.allCoins = returnedData
            }
            .store(in: &cancellabels)
        
        marketDataService.$marketData
            .compactMap { $0?.data }
            .sink { [weak self] returnedData in
                self?.marketData = returnedData
                self?.addStatisticsValue()
            }
            .store(in: &cancellabels)
    }
    
    func addStatisticsValue() {
        self.statistics.append(StatisticModel(title: "Market Cap", value: "\(self.marketData?.marketCap ?? "0")"))
    }
    
    private func filterCoins(searchText: String, coins: [CoinModel]) -> [CoinModel] {
        guard !searchText.isEmpty else {
            return coins
        }
        
        let lowercasedText = searchText.lowercased()
        
        return coins.filter { coin -> Bool in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText)
        }
    }
}
