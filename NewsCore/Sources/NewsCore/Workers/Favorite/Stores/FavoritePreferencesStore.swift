//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation

public struct FavoritePreferencesStore: FavoriteStore {
    private let preferences: PreferencesType
    
    public init(preferences: PreferencesType) {
        self.preferences = preferences
    }
}

public extension FavoritePreferencesStore {
    
    func fetchArticles(completion: @escaping (Result<[String], DataError>) -> Void) {
        guard let ids = preferences.get(.favoriteArticles), !ids.isEmpty else {
            completion(.success([]))
            return
        }
        
        completion(.success(ids))
    }
    
    func addArticle(id: String) {
        guard !hasArticle(id: id) else { return }
        
        preferences.set(
            (preferences.get(.favoriteArticles) ?? []) + [id],
            forKey: .favoriteArticles
        )
    }
    
    func removeArticle(id: String) {
        preferences.set(
            preferences.get(.favoriteArticles)?.filter { $0 != id },
            forKey: .favoriteArticles
        )
    }
    
    func hasArticle(id: String) -> Bool {
        preferences.get(.favoriteArticles)?.contains(id) == true
    }
}
