//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 02/08/2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .foregroundStyle(Color.theme.accentColor)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperProvider.shared.coin)
}
