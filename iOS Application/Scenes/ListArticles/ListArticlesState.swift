//
//  ListArticlesState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Combine
import NewsCore

/// Sub-state instead of exposing entire root store to view.
class ListArticlesState: StateType, ObservableObject {
    // Immutable from the outside
    @Published private(set) var articles: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(parent store: AppStore) {
        // Expose store through local properties
        self.articles = store.articles
        
        // One-way binding for unidirectional flow
        store.$articles
            .assign(to: \Self.articles, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(model: [Article]) {
        self.articles = model
    }
}
