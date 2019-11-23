//
//  DateFormatter.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-17.
//

import Foundation

public extension DateFormatter {
    
    /// A formatter that converts between dates and their ISO 8601 string representations.
    ///
    /// When `JSONEncoder` accepts a custom `ISO8601DateFormatter`, this convenience initializer will no longer be needed.
    ///
    /// - Parameter dateFormat: The date format string used by the receiver.
    convenience init(iso8601Format dateFormat: String) {
        self.init()
        
        self.calendar = Calendar(identifier: .iso8601)
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(identifier: "GMT")
        self.dateFormat = dateFormat
    }
}
