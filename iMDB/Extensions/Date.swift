//
//  Date.swift
//  iMDB
//
//  Created by Furkan Doğan on 1.03.2024.
//

import Foundation

extension Date {
    
    // 2001-11-10
    init(dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    func asShortDateString() -> String {
        return yearFormatter.string(from: self)
    }
}
