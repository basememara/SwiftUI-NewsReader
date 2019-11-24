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
    private var cancellable: AnyCancellable?

    private let reducer: ListArticlesReducer
    
    init(from state: AppState, with reducer: ListArticlesReducer) {
        self.articles = state.articles
        self.reducer = reducer
        
        self.cancellable = state.$articles // Subscribe
            .assign(to: \Self.articles, on: self)
    }
}

extension ListArticlesState {
    
    func dispatch(_ action: ListArticlesAction) {
        reducer.reduce(with: action)
    }
}
