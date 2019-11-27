//
//  ShowArticleReducer.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-25.
//

import NewsCore

struct ShowArticleReducer: ReducerType {
    private let favoriteProvider: FavoriteProviderType
    
    init(favoriteProvider: FavoriteProviderType) {
        self.favoriteProvider = favoriteProvider
    }
}

// MARK: - Dispatcher

extension ShowArticleReducer {
    
    func apply(_ state: AppState, _ action: ShowArticleAction) {
        switch action {
        case .toggleFavorite(let id):
            toggleFavorite(id: id) { $0(state) }
        }
    }
}

// MARK: - Logic

private extension ShowArticleReducer {
    
    func toggleFavorite(id: String, mutate state: @escaping MutateStateFunction) {
        favoriteProvider.toggleArticle(id: id)
        
        favoriteProvider.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            // Mutate state since now complete
            state {
                $0.favorites = value
            }
        }
    }
}
