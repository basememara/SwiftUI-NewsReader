//
//  ShowArticleAction.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

enum ShowArticleAction: ActionType {
    case toggleFavorite(String)
    case loadFavorites([String])
}

// MARK: - Logic

struct ShowArticleActionCreator: ActionCreatorType {
    private let favoriteProvider: FavoriteProviderType
    private let dispatch: (ShowArticleAction) -> Void
    
    init(
        favoriteProvider: FavoriteProviderType,
        dispatch: @escaping (ShowArticleAction) -> Void
    ) {
        self.favoriteProvider = favoriteProvider
        self.dispatch = dispatch
    }
}

extension ShowArticleActionCreator {
    
    func toggleFavorite(id: String) {
        favoriteProvider.toggleArticle(id: id)
        dispatch(.toggleFavorite(id))
        
        favoriteProvider.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.dispatch(.loadFavorites(value))
        }
    }
}
