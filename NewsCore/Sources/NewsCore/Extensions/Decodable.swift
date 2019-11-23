//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

/// Skips failed elements during decoding instead exiting collection completely; lossy array decoding.
public struct FailableCodableArray<Element: Decodable>: Decodable {
    // https://github.com/phynet/Lossy-array-decode-swift4
    private struct DummyCodable: Codable {}
    
    private struct FailableDecodable<Base: Decodable>: Decodable {
        let base: Base?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.base = try? container.decode(Base.self)
        }
    }
    
    private(set) public var elements: [Element]
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [Element] = []
        
        if let count = container.count {
            elements.reserveCapacity(count)
        }
        
        while !container.isAtEnd {
            guard let element = try container.decode(FailableDecodable<Element>.self).base else {
                _ = try? container.decode(DummyCodable.self)
                continue
            }
            
            elements.append(element)
        }
        
        self.elements = elements
    }
}
