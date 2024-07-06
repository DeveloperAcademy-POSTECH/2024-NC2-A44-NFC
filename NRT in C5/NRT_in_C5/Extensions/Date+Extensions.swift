//
//  Date+Extensions.swift
//  NRT in C5
//
//  Created by EVIE on 7/5/24.
//

import Foundation

extension Date {
    func toString(by format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
