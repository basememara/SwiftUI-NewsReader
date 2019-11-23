//
//  String.Keys.swift
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public protocol PreferencesStore {
    
    /// Retrieves the value from user defaults that corresponds to the given key.
    ///
    /// - Parameter key: The key that is used to read the user defaults item.
    func get<T>(_ key: String.Key<T?>) -> T?
    
    /// Stores the value in the user defaults item under the given key.
    ///
    /// - Parameters:
    ///   - value: Value to be written to the user defaults.
    ///   - key: Key under which the value is stored in the user defaults.
    func set<T>(_ value: T?, forKey key: String.Key<T?>)
    
    /// Deletes the single user defaults item specified by the key.
    ///
    /// - Parameter key: The key that is used to delete the user default item.
    /// - Returns: True if the item was successfully deleted.
    func remove<T>(_ key: String.Key<T?>)
}

public protocol PreferencesType: PreferencesStore {}

// MARK: - Subtypes

extension String.Keys {
    static let favorites = String.Key<[Int]?>("favorites")
}
