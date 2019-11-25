//
//  ListArticlesState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import Combine

class ListArticlesState: StateType, ObservableObject {
    @Published private(set) var articles: [Article]
    
    private var cancellable = Set<AnyCancellable>()
    
    init(from parent: AppState) {
        // Expose state through local properties
        self.articles = parent.articles
        
        // One-way binding for unidirectional flow
        parent.$articles
            .assign(to: \Self.articles, on: self)
            .store(in: &cancellable)
    }
    
    /// Non-reactive initializer for static state. Primarily used for previews and testing.
    init(articles: [Article]) {
        self.articles = articles
    }
}
