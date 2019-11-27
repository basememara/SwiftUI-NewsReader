//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-11-24.
//

import Foundation

public struct FavoriteProvider: FavoriteProviderType {
    private let store: FavoriteStore
    
    public init(store: FavoriteStore) {
        self.store = store
    }
}

public extension FavoriteProvider {
    
    func fetchArticles(completion: @escaping (Result<[String], DataError>) -> Void) {
        store.fetchArticles(completion: completion)
    }
    
    func addArticle(id: String) {
        store.addArticle(id: id)
    }
    
    func removeArticle(id: String) {
        store.removeArticle(id: id)
    }
    
    func toggleArticle(id: String) {
        hasArticle(id: id) ? removeArticle(id: id) : addArticle(id: id)
    }
    
    func hasArticle(id: String) -> Bool {
        store.hasArticle(id: id)
    }
}
