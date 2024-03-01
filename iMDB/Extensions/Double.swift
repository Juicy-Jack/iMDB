//
//  Double.swift
//  iMDB
//
//  Created by Furkan Doğan on 1.03.2024.
//

import Foundation

extension Double {
    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1.2"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.1f", self)
    }
}
