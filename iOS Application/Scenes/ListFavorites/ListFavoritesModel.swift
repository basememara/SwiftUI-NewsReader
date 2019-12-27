//
//  ShowArticleModel.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import Combine
import NewsCore

class ListFavoritesModel: ModelType, ObservableObject {
    // Immutable from the outside
    @Published private(set) var favorites: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(root state: AppState) {
        self.favorites = state.articles
            .filter { state.favorites.contains($0.id) }
        
        // One-way binding for unidirectional flow
        state.$favorites
            .map { ids in
                // TODO: Optimize lookup
                ids.compactMap { id in
                    state.articles.first { $0.id == id }
                }
            }
            .assign(to: \Self.favorites, on: self)
            .store(in: &cancellable)
        
        // TODO: Bind to articles updates in case title changes for example
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(articles: [Article]) {
        self.favorites = articles
    }
}
