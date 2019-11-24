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
    
    init(from state: AppState) {
        self.articles = state.articles
        
        // Subscriptions
        state.$articles
            .assign(to: \Self.articles, on: self)
            .store(in: &cancellable)
    }
}
