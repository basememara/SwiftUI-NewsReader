//
//  ShowArticleDispatch.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-30.
//

import NewsCore

struct ShowArticleDispatch: DispatchType {
    private let favoriteProvider: FavoriteProviderType
    private let reducer: (ShowArticleAction) -> Void
    
    init(
        favoriteProvider: FavoriteProviderType,
        reducer: @escaping (ShowArticleAction) -> Void
    ) {
        self.favoriteProvider = favoriteProvider
        self.reducer = reducer
    }
}

// MARK: - Logic

extension ShowArticleDispatch {
    
    func toggleFavorite(id: String) {
        favoriteProvider.toggleArticle(id: id)
        reducer(.toggleFavorite(id))
        
        favoriteProvider.fetchArticles {
            guard case .success(let value) = $0 else {
                // TODO: Handle error
                return
            }
            
            self.reducer(.loadFavorites(value))
        }
    }
}
