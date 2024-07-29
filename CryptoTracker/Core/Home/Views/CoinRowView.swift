//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 26/07/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn : Bool
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {
        CoinRowView(coin: DeveloperProvider.shared.coin, showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
}

#Preview {
        CoinRowView(coin: DeveloperProvider.shared.coin, showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
}


extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accentColor)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "0.00")
               
        }
        .foregroundStyle(Color.theme.accentColor)
    }
    
    private var rightColumn: some View {
        
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimal())
                .bold()
                .foregroundStyle(Color.theme.accentColor)
            Text(coin.priceChangePercentage24H?.asPrecentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0.0 > 0)  ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
