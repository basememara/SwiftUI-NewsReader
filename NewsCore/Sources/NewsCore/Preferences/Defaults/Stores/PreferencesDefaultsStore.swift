//
//  PreferencesDefaultsStore.swift
//  NewCore
//
//  Created by Basem Emara on 2019-11-19.
//

import Foundation

public struct PreferencesDefaultsStore: PreferencesStore {
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}

public extension PreferencesDefaultsStore {
    
    func get<T>(_ key: String.Key<T?>) -> T? {
        return defaults[key]
    }
    
    func set<T>(_ value: T?, forKey key: String.Key<T?>) {
        defaults[key] = value
    }
    
    func remove<T>(_ key: String.Key<T?>) {
        defaults.remove(key)
    }
}
