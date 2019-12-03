//
//  ShowArticleReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ShowArticleReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ShowArticleAction) -> AppState {
        switch action {
        case .toggleFavorite:
            break
        case .loadFavorites(let value):
            state.favorites = value
        }
        
        return state
    }
}
