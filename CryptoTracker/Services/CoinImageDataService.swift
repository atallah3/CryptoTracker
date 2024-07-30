//
//  CoinImageDataService.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI
import Combine

class CoinImageDataService {
    
    @Published var image: UIImage? = nil
    
    let coin: CoinModel
    private var imageSubscribtion: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getImage()
    }
    
    private func getImage() {
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
               return UIImage(data: data)
            })
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscribtion?.cancel()
            })
    }
}
