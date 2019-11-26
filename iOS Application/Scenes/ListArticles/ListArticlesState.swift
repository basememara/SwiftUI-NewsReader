//
//  ListArticlesState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Combine
import NewsCore

class ListArticlesState: StateType, ObservableObject {
    // Immutable from the outside
    @Published private(set) var articles: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(from store: AppStore) {
        // Expose store through local properties
        self.articles = store.articles
        
        // One-way binding for unidirectional flow
        store.$articles
            .assign(to: \Self.articles, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(articles: [Article]) {
        self.articles = articles
    }
}
