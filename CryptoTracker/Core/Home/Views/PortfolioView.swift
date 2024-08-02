//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 02/08/2024.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckmarkButton = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                }
                
                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { XMarkView() }
                ToolbarItem(placement: .topBarTrailing) { topBarTrailingButtons }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperProvider.shared.homeVM)
}



extension PortfolioView {
    
    private var coinLogoList: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    coin.id == selectedCoin?.id ?
                                    Color.theme.green : Color.clear, lineWidth: 1.0)
                        )
                    
                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func getCurrentHoldingValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0.0)
        }
        return 0.0
    }
    
    private var portfolioInputSection: some View  {
        
        VStack (spacing: 20){
            HStack {
                Text("Current price of \(selectedCoin?.symbol ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimal() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("EX: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Curren value:")
                Spacer()
                Text(getCurrentHoldingValue().asCurrencyWith2Decimal())
            }
        }
        .animation(.none, value: UUID())
    }
    
    private var topBarTrailingButtons: some View {
        
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmarkButton ? 1 : 0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("save".uppercased())
            })
            .opacity(selectedCoin?.currentHoldings != Double(quantityText) && selectedCoin != nil ?
                     1 : 0
            )
        }
        .foregroundStyle(Color.theme.accentColor)
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        //        save to portfolio
        
        showCheckmark()
        hideKeyBoard()
        hideCheckmarkAfter2Sec()
        
    }
    
    private func showCheckmark() {
        withAnimation(.easeIn) {
            showCheckmarkButton = true
            removeSelectedCoin()
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func hideKeyBoard() {
        UIApplication.shared.endEditing()
    }
    
    private func hideCheckmarkAfter2Sec() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmarkButton = false
            }
        }
    }
}
