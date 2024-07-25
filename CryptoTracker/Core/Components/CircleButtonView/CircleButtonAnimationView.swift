//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 25/07/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0.0 : 1)
            .animation(animate ? Animation.easeInOut(duration: 1.0) : .none , value: animate)
            
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
        .foregroundStyle(.red)
        .frame(width: 100)
}
