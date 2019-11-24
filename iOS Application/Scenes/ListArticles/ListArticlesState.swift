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
    
    init(from state: AppState) {
        self.articles = state.articles
        
        self.cancellable = state.$articles // Subscribe
            .assign(to: \Self.articles, on: self)
    }
}
