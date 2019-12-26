//
//  ListArticlesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

struct ListArticlesReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ListArticlesAction) -> AppState {
        let articles: [Article]
        
        switch action {
        case .loadArticles(let value):
            articles = value
        case .clearArticles:
            articles = []
        }
        
        // Mutate global state to propagate changes
        state.listArticles.articles = articles
        
        return state
    }
}
