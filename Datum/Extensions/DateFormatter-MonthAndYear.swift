//
//  DateFormatter-MonthAndYear.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-06.
//

import Foundation

extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}
