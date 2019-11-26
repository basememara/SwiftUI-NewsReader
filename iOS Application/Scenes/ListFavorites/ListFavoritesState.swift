//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import Combine
import NewsCore

class ListFavoritesState: StateType, ObservableObject {
    // Immutable from the outside
    @Published private(set) var favorites: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(parent store: AppStore) {
        self.favorites = store.articles
            .filter { store.favorites.contains($0.id) }
        
        // One-way binding for unidirectional flow
        store.$favorites
            .map { value in
                // TODO: Optimize lookup
                value.compactMap { article in
                    store.articles.first { $0.id == article }
                }
            }
            .assign(to: \Self.favorites, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(model: [Article]) {
        self.favorites = model
    }
}
