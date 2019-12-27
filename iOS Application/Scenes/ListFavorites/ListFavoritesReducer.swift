//
//  ListFavoritesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ListFavoritesReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ListFavoritesAction) {
        switch action {
        case .loadFavorites(let value):
            let favorites = state.articles
                .filter { value.contains($0.id) }
            
            // Mutate global state to propagate changes
            state.favorites = favorites.map { $0.id }
        case .toggleFavorite(let id):
            // Mutate global state to propagate changes
            guard state.articles.contains(where: { $0.id == id }),
                !state.favorites.contains(where: { $0 == id }) else {
                    // Remove non-existing or toggled article
                    state.favorites.removeAll { $0 == id }
                    break
            }
            
            state.favorites.append(id)
        }
    }
}
