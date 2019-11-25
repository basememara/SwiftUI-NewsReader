//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore
import Combine

class ListFavoritesState: StateType, ObservableObject {
    @Published private(set) var favorites: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    init(from state: AppState) {
        self.favorites = state.articles
            .filter { state.favorites.contains($0.id) }
        
        // One-way binding for unidirectional flow
        state.$favorites
            .map { value in
                // TODO: Optimize lookup
                value.compactMap { article in
                    state.articles.first { $0.id == article }
                }
            }
            .assign(to: \Self.favorites, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(favorites: [Article]) {
        self.favorites = favorites
    }
}
