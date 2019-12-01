//
//  ListArticlesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

struct ListArticlesReducer: ReducerType {
    
    func apply(_ state: AppState, _ action: ListArticlesAction) -> AppState {
        switch action {
        case .loadArticles(let value):
            state.articles = value
        case .clearArticles:
            state.articles = []
        }
        
        return state
    }
}
