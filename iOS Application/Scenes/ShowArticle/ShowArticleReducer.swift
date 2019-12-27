//
//  ShowArticleReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ShowArticleReducer: ReducerType {
    private let listFavoritesReducer: ListFavoritesReducer
    
    init(listFavoritesReducer: ListFavoritesReducer) {
        self.listFavoritesReducer = listFavoritesReducer
    }
    
    func reduce(_ state: AppState, _ action: ShowArticleAction) {
        switch action {
        case .toggleFavorite(let id):
            // TODO: Smelly; better way to call multiple reducers?
            listFavoritesReducer.reduce(state, .toggleFavorite(id))
        }
    }
}
