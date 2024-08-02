//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let coin: CoinModel
    let dataService: CoinImageDataService
    var imageSubscribtion = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageDataService(coin: coin)
        self.isLoading = true
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &imageSubscribtion)

    }
}
