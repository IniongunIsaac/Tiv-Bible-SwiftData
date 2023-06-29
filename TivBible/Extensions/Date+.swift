//
//  Date+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 29/06/2023.
//

import Foundation

extension Date {
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
    func dateOnly(format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
