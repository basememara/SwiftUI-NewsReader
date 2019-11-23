//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

public extension UserDefaults {
    
    /// Gets and sets the value from User Defaults that corresponds to the given key.
    subscript<T>(key: String.Key<T?>) -> T? {
        get { object(forKey: key.name) as? T }
        
        set {
            guard let value = newValue else { return remove(key) }
            set(value, forKey: key.name)
        }
    }
    
    /// Removes the single User Defaults item specified by the key.
    ///
    /// - Parameter key: The key that is used to delete the user defaults item.
    func remove<T>(_ key: String.Key<T?>) {
        removeObject(forKey: key.name)
    }
}

public extension UserDefaults {
    
    /// Removes all keys and values from User Defaults.
    /// - Note: This method only removes keys on the receiver `UserDefaults` object.
    ///         System-defined keys will still be present afterwards.
    func removeAll() {
        dictionaryRepresentation().forEach {
            removeObject(forKey: $0.key)
        }
    }
}
