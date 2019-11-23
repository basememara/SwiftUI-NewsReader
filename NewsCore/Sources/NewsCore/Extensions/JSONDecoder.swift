//
//  JSONDecoder.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-14.
//

import Foundation

public extension JSONDecoder {
    private static let dateFormatterPrecise = DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private static let dateFormatterNonPrecise = DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
    private static let dateFormatterGMT = DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ssZ")
    
    static let `default` = JSONDecoder().with {
        $0.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            if let date = dateFormatterPrecise.date(from: dateString) {
                return date
            }
            
            if let date = dateFormatterNonPrecise.date(from: dateString) {
                return date
            }
            
            if let date = dateFormatterGMT.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        }
    }
}

public extension JSONDecoder {
    
    /// Decodes an instance of the indicated type.
    /// - Parameters:
    ///   - type: The type to decode.
    ///   - string: The string representation of the JSON object.
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        guard let data = string.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: "Could not encode data from string."
            ))
        }
        
        return try decode(type, from: data)
    }
}

public extension JSONDecoder {
    
    /// Decodes an instance of the indicated type.
    /// - Parameters:
    ///   - type: The type to decode.
    ///   - name: The name of the embedded resource.
    ///   - bundle: The bundle of the embedded resource.
    func decode<T>(_ type: T.Type, forResource name: String?, inBundle bundle: Bundle) throws -> T where T: Decodable {
        guard let url = bundle.url(forResource: name, withExtension: nil) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: "Could not find the resource."
            ))
        }
        
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            return try decode(type, from: data)
        } catch {
            throw error
        }
    }
}
