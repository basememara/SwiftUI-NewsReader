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
    
    private let reducer: ListArticlesReducer
    private var cancellable: AnyCancellable?
    
    init(from state: AppState, with reducer: ListArticlesReducer) {
        self.articles = state.articles
        self.reducer = reducer
        
        // Subscribe to changes so subscriber refresh
        self.cancellable = state.$articles
            .assign(to: \Self.articles, on: self)
    }
}

extension ListArticlesState {
    
    func dispatch(_ action: ListArticlesAction) {
        reducer.reduce(with: action)
    }
}
