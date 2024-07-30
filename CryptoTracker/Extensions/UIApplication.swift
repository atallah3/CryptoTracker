//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 30/07/2024.
//

import SwiftUI

extension UIApplication {
    
    /// Dismisses the keyboard if it is currently presented on the screen.
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
