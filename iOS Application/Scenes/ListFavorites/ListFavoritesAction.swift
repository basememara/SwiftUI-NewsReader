//
//  ShowArticleAction.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-24.
//

import NewsCore

enum ListFavoritesAction: ActionType {
    case loadFavorites([String])
    case toggleFavorite(String)
}

// MARK: - Logic

struct ListFavoritesActionCreator: ActionCreatorType {
    private let favoriteProvider: FavoriteProviderType
    private let dispatch: (ListFavoritesAction) -> Void
    
    init(
        favoriteProvider: FavoriteProviderType,
        dispatch: @escaping (ListFavoritesAction) -> Void
    ) {
        self.favoriteProvider = favoriteProvider
        self.dispatch = dispatch
    }
}

extension ListFavoritesActionCreator {
    
    func fetchFavorites() {
        favoriteProvider.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.dispatch(.loadFavorites(value))
        }
    }
}

extension ListFavoritesActionCreator {
    
    func toggleFavorite(id: String) {
        favoriteProvider.toggleArticle(id: id)
        fetchFavorites() // TODO: Optimize
    }
}
