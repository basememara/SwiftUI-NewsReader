//
//  ListFavoritesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ListFavoritesReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ListFavoritesAction) -> AppState {
        switch action {
        case .loadFavorites(let value):
            state.favorites = value
        case .toggleFavorite:
            break
        }
        
        return state
    }
}
