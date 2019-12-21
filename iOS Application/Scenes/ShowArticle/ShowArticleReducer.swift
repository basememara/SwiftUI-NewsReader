//
//  ShowArticleReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ShowArticleReducer: ReducerType {
    
    func reduce(_ state: AppState, _ action: ShowArticleAction) -> ShowArticleModel {
        switch action {
        case .toggleFavorite(let id):
            state.showArticle.isFavorite.toggle()
            
            let article = state.showArticle.article
            
            // TODO: Split into multiple reducers?
            if let index = state.listFavorites.favorites
                .firstIndex(where: { $0.id == id })
            {
                state.listFavorites.favorites[index] = article
            } else {
                state.listFavorites.favorites.append(article)
            }
        }
        
        return state.showArticle
    }
}
