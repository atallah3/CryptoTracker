//
//  Double.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation


extension Double {
  
    /// converts a double into currency with 2  decimal places
    /// ```
    /// 1234.56 -> $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// converts a double into currency to string  with 2  decimal places
    /// ```
    /// 1234.56 -> "$1,234.56"
    /// ```
    func asCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number ) ?? "0.00"
    }
    
    /// converts a double into currency with 2 - 6 decimal places
    /// ```
    /// 1234.56 -> $1,234.56
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// converts a double into currency to string  with 2 - 6 decimal places
    /// ```
    /// 1234.56 -> "$1,234.56"
    /// 12.3456 -> "$12,3456"
    /// 0.123456 -> "$0,123456"
    /// ```
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number ) ?? "0.0"
    }
    
    /// converts a double into to Two decimal fraction
    /// ```
    /// 1.2345 -> "1.56"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    /// converts a double into to Two decimal fraction with precent symbol
    /// ```
    /// 1.2345 -> "1.23%"
    /// ```
    func asPrecentString() -> String {
        return "\(asNumberString())% "
    }
}
