//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    let dataService = CoinDataService()
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedData in
                self?.allCoins = returnedData
            }
            .store(in: &cancellabels)
    }
}
