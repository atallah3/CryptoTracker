//
//  HomeStatisticsView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 31/07/2024.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatisticsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperProvider.shared.homeVM)
}
