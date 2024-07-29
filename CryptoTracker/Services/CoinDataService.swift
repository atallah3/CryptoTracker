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
       
       coinSubscribtion = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap (handelOutput)
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("finishes")
                case .failure(let error):
                    print("Error downloading Coins please try again \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins.append(contentsOf: returnedCoins)
                self?.coinSubscribtion?.cancel()
            }
    }
    
    func handelOutput(output : URLSession.DataTaskPublisher.Output) throws -> Data{
        guard
            let respnse = output.response as? HTTPURLResponse ,
            respnse.statusCode>=200 && respnse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
