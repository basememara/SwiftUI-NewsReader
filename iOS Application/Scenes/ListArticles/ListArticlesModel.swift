//
//  ListArticlesModel.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import Combine
import NewsCore

/// Sub-state instead of exposing entire root state to view.
class ListArticlesModel: ModelType, ObservableObject {
    // Immutable from the outside to enforce unidirectional flow
    // View must dispatch an action to mutate the model
    @Published private(set) var articles: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Setup
    
    init(root state: AppState) {
        // Expose state through local properties
        self.articles = state.articles
        
        // One-way binding for unidirectional flow
        state.$articles
            .assign(to: \Self.articles, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(articles: [Article]) {
        self.articles = articles
    }
}
