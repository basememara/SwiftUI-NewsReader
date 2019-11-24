//
//  Preferences.swift
//  NewsCore
//
//  Created by Basem Emara on 2019-11-18.
//

import Foundation

public struct Preferences: PreferencesType {
    private let store: PreferencesStore
    
    public init(store: PreferencesStore) {
        self.store = store
    }
}

public extension Preferences {
    
    func get<T>(_ key: String.Key<T?>) -> T? {
        return store.get(key)
    }
    
    func set<T>(_ value: T?, forKey key: String.Key<T?>) {
        store.set(value, forKey: key)
    }
    
    func remove<T>(_ key: String.Key<T?>) {
        store.remove(key)
    }
}

public extension PreferencesType {
    
    /// Returns the current favorite articles.
    var favoriteArticles: [String] { self.get(.favoriteArticles) ?? [] }
    
    /// Removes all the user defaults items.
    func removeAll() {
        remove(.favoriteArticles)
    }
}
