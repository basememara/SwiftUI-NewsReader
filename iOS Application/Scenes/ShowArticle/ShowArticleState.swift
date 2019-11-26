//
//  ShowArticleState.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore
import Combine

class ShowArticleState: StateType, ObservableObject {
    // Immutable from the outside
    @Published private(set) var article: Article
    @Published private(set) var isFavorite: Bool
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(from store: AppStore, article: Article) {
        // Expose store through local properties
        self.article = article
        self.isFavorite = store.favorites.contains(article.id)
        
        // One-way binding for unidirectional flow
        store.$favorites
            .map { $0.contains(self.article.id) }
            .assign(to: \Self.isFavorite, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(article: Article, isFavorite: Bool) {
        self.article = article
        self.isFavorite = isFavorite
    }
}
