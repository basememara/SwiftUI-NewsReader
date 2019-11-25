//
//  ListArticlesState.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-22.
//

import NewsCore
import Combine

class ListArticlesState: StateType, ObservableObject {
    @Published private(set) var articles: [Article] // Immutable from the outside
    
    private var cancellable = Set<AnyCancellable>()
    
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
