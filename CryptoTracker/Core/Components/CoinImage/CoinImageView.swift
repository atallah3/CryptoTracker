//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {

        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else if vm.isLoading {
            ProgressView()
        } else {
            Image(systemName: "questionmark")
                .foregroundStyle(Color.theme.secondaryTextColor)
        }
        
    }
}

#Preview {
    CoinImageView(coin: DeveloperProvider.shared.coin)
}
