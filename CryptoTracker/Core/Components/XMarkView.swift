//
//  XMarkView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 02/08/2024.
//

import SwiftUI

struct XMarkView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.theme.accentColor)
                .font(.headline)
        })
    }
}

#Preview {
    XMarkView()
}
