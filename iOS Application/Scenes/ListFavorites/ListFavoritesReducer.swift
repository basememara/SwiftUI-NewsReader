//
//  ListFavoritesReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ListFavoritesReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ListFavoritesAction) -> ListFavoritesModel {
        switch action {
        case .loadFavorites(let value):
            let articles = state.listArticles?.articles
                .filter { value.contains($0.id) }
                    ?? []
            
            // Mutate global state to propagate changes
            if state.listFavorites == nil {
                state.listFavorites = ListFavoritesModel(
                    articles: articles
                )
            } else {
                state.listFavorites?.favorites = articles
            }
        case .toggleFavorite(let id):
            guard let article = state.listArticles?.articles
                .first(where: { $0.id == id }) else {
                    break
            }
            
            if let index = state.listFavorites?.favorites
                .firstIndex(where: { $0.id == id })
            {
                state.listFavorites?.favorites[index] = article
            } else {
                state.listFavorites?.favorites.append(article)
            }
            
            // TODO: Split into multiple reducers?
            state.showArticle?.isFavorite.toggle()
        }
        
        return state.listFavorites! // TODO: Fix unwrapping
    }
}
