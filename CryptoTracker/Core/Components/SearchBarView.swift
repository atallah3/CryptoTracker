//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ?
                    Color.theme.secondaryTextColor :
                    Color.theme.accentColor
                )
            
            TextField("Search by name or symbol..", text: $searchText)
                .foregroundStyle(Color.theme.accentColor)
                .autocorrectionDisabled(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.theme.accentColor)
                        .padding()
                        .offset(x: 10.0)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
                
        }
        .padding()
        .font(.headline)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accentColor.opacity(0.15),
                        radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
