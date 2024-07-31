//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 31/07/2024.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accentColor)
           
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: stat.percentageChange ?? 0 >= 0 ? 0 : 180))

                Text(stat.percentageChange?.asPrecentString() ?? "0")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                stat.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red
            )
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperProvider.shared.stat1)
}

#Preview {
    StatisticView(stat: DeveloperProvider.shared.stat2)
}

#Preview {
    StatisticView(stat: DeveloperProvider.shared.stat3)
}
