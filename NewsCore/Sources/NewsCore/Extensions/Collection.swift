//
//  Collection.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation

public extension Collection {
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    subscript(safe index: Index) -> Element? {
        // http://www.vadimbulavin.com/handling-out-of-bounds-exception/
        indices.contains(index) ? self[index] : nil
    }
}
