//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title 1", value: "Value 1", percentageChange: 1.23),
        StatisticModel(title: "Title 2", value: "Value 2", percentageChange: -0.45),
        StatisticModel(title: "Title 3", value: "Value 3", percentageChange: 0.00)
    ]
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    let dataService = CoinDataService()
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map( filterCoins )
            .sink { [weak self] returnedData in
                self?.allCoins = returnedData
            }
            .store(in: &cancellabels)
        
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
