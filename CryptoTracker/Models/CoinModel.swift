//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 25/07/2024.
//

import Foundation

// API and Response :  
/*

URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

URLResponse :
{
      "id":"bitcoin",
      "symbol":"btc",
      "name":"Bitcoin",
      "image":"https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
      "current_price":64239,
      "market_cap":1266840465843,
      "market_cap_rank":1,
      "fully_diluted_valuation":1348341958634,
      "total_volume":35267432874,
      "high_24h":67073,
      "low_24h":63880,
      "price_change_24h":-1484.5677864166792,
      "price_change_percentage_24h":-2.2588,
      "market_cap_change_24h":-30970703654.560303,
      "market_cap_change_percentage_24h":-2.38638,
      "circulating_supply":19730640.0,
      "total_supply":21000000.0,
      "max_supply":21000000.0,
      "ath":73738,
      "ath_change_percentage":-12.85658,
      "ath_date":"2024-03-14T07:10:36.635Z",
      "atl":67.81,
      "atl_change_percentage":94662.8759,
      "atl_date":"2013-07-06T00:00:00.000Z",
      "roi":null,
      "last_updated":"2024-07-25T05:37:42.417Z",
      "sparkline_in_7d":{
         "price":[
            64101.49229397971,
            64543.149741454596
         ]
      },
      "price_change_percentage_24h_in_currency":-2.258798177684614
   }



struct WelcomeElement {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank: Int
    let fullyDilutedValuation: Int?
    let totalVolume: Int
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double
    let totalSupply, maxSupply: Double?
    let ath, athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let roi: Roi?
    let lastUpdated: String
    let sparklineIn7D: SparklineIn7D
    let priceChangePercentage24HInCurrency: Double
}

// MARK: - Roi
struct Roi {
    let times: Double
    let currency: Currency
    let percentage: Double
}

enum Currency: String {
    case btc
    case eth
    case usd
}

// MARK: - SparklineIn7D
struct SparklineIn7D {

*/
  


struct CoinModel: Identifiable, Codable{
        let id, symbol, name: String
        let image: String
        let currentPrice: Double
        let marketCap, marketCapRank: Int?
        let fullyDilutedValuation: Int?
        let totalVolume: Int?
        let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
        let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
        let totalSupply, maxSupply: Double?
        let ath, athChangePercentage: Double?
        let athDate: String?
        let atl, atlChangePercentage: Double?
        let atlDate: String?
        let lastUpdated: String?
        let sparklineIn7D: SparklineIn7D?
        let priceChangePercentage24HInCurrency: Double?
        let currentHolding: Double?
    
    func updateHoldings(_ amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHolding: amount)
    }
    
    var currentHoldingValue: Double {
        (currentHolding ?? 0) * currentPrice
    }
    
    var rank : Int {
        Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]
}
