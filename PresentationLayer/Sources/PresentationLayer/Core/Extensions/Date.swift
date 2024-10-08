//
//  File.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import Foundation

extension Date {
    func toString(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = dateStyle
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
}
