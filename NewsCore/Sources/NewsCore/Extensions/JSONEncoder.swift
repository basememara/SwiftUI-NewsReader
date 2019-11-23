//
//  JSONEncoder.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

public extension JSONEncoder {
    
    static let `default` = JSONEncoder().with {
        $0.dateEncodingStrategy = .formatted(
            DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ssZ")
        )
    }
}
